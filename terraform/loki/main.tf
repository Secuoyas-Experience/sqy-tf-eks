variable "cluster_name" {
  type        = string
  description = "eks cluster name"
}

##################################
############## DATA ##############
##################################

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

data "aws_iam_openid_connect_provider" "eks_cluster_oidc" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

##################################
############ S3 BUCKET ###########
##################################

module "loki_bucket" {
  source       = "../modules/eks/s3/bucket"
  name         = "toolbox-loki"
  description  = "bucket to make loki storage scalable"
  cluster_name = var.cluster_name
  account_id   = data.aws_caller_identity.current.account_id
}

module "service_account_can_read_s3" {
  depends_on           = [module.loki_bucket]
  source               = "../modules/eks/s3/service_account_can_read_s3"
  cluster_oidc_arn     = data.aws_iam_openid_connect_provider.eks_cluster_oidc.arn
  cluster_oidc_name    = data.aws_iam_openid_connect_provider.eks_cluster_oidc.id
  bucket_name          = module.loki_bucket.bucket_name
  role_name            = "CanReadLokiS3Role"
  service_account_name = "system:serviceaccount:monitoring:can-read-loki-s3"
}

module "service_account_can_write_s3" {
  depends_on           = [module.loki_bucket]
  source               = "../modules/eks/s3/service_account_can_write_s3"
  cluster_oidc_arn     = data.aws_iam_openid_connect_provider.eks_cluster_oidc.arn
  cluster_oidc_name    = data.aws_iam_openid_connect_provider.eks_cluster_oidc.id
  bucket_name          = module.loki_bucket.bucket_name
  role_name            = "CanWriteLokiS3Role"
  service_account_name = "system:serviceaccount:monitoring:can-write-loki-s3"
}

##################################
############## HELM ##############
##################################

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

resource "helm_release" "loki_app" {
  depends_on        = [module.loki_bucket]
  name              = "loki"
  repository        = "https://grafana.github.io/helm-charts"
  chart             = "grafana/loki"
  version           = "5.5.1"
  namespace         = "loki"
  atomic            = true
  cleanup_on_fail   = true
  reset_values      = true
  dependency_update = true

  set {
    name  = "serviceAccount.name"
    value = "loki"
  }

  set {
    name  = "serviceAccount.create"
    value = true
  }

  set {
    name  = "serviceAccount.annotations"
    value = "[eks.amazonaws.com/role-arn:${module.service_account_can_write_s3.role_arn}]"
    type  = "auto"
  }
}