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

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token = "k8s-aws-v1.aHR0cHM6Ly9zdHMuYW1hem9uYXdzLmNvbS8_QWN0aW9uPUdldENhbGxlcklkZW50aXR5JlZlcnNpb249MjAxMS0wNi0xNSZYLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFTSUFRSExXSVBNQlRaUVJVSTYzJTJGMjAyMzA1MTQlMkZ1cy1lYXN0LTElMkZzdHMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDIzMDUxNFQwMTQ4MjhaJlgtQW16LUV4cGlyZXM9NjAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JTNCeC1rOHMtYXdzLWlkJlgtQW16LVNlY3VyaXR5LVRva2VuPUlRb0piM0pwWjJsdVgyVmpFTCUyRiUyRiUyRiUyRiUyRiUyRiUyRiUyRiUyRiUyRiUyRndFYURHVjFMV05sYm5SeVlXd3RNU0pHTUVRQ0lCWlVVeDJiVExja1EwR0R3dSUyQkFwNzRZRHpmZEUlMkZnJTJGaUFZNkFkYW83c01XQWlCWmFqbXhEVDV1MFhBblREQzlrbnMzMWxNNk1rV2owWlg4T2Q2NUZMYlg3aXFhQXdqWSUyRiUyRiUyRiUyRiUyRiUyRiUyRiUyRiUyRiUyRjhCRUFBYUREQXhOVGd4TnpJM05qRTJNeUlNbWxpMXBLd2JTM21EJTJGRUxJS3U0Q3VKZW9hM2NRb3BpM1IlMkJkQjFwTEVlVjZDa2dvand0bVV6dVBZd0xFWGFFMiUyQnlJckdIMmVUZFlaSDZCcG01OEsxNWlWV1hXY2hEZVFIcmV0UVglMkJTbnpGdm5xVEVoZklwZlh2M2Y3VU9Ec0Z0cDAyOSUyRmxiVEQzR3pkRGVQUjM0bXBHdEpBQVNJYnNieEt0M1kzQmZPODROa0xuQURaQ2lyTm4ydm1ESE9UUWoweHNDeDlLb0FXQnpscWlCaDZYVnpIU0NRRlF1NUpsWTQ0Mlk0ZyUyQlBpMnU1Z3o0N2dSaSUyRnpMbUVxRHZhcUhRbXVWUGlPaFJJN2hMQk9aRVFEWWh6NmpzclB1NWZrcG9ZU3J3MFllUkxaTkpmT08yTXp1ODhrVjRTVHhaQUMlMkYyZ08xcyUyRlVUakFyZkw3cWNHbDB4VU1EcHV4NVdJUzZWYnh0Uno3YiUyQjlzd0s0T3VSWGJ1RyUyQkxQUzNkWmcxZGElMkJLWVJUWGFzdkdSOFUlMkI1U3BlQUFZYmhCaiUyRjFLalJsNFpTVXNnQkFIZWpIM1F6c3pCRyUyRkpYdnpERkwwdDAlMkJudVBsTk9Rb2hqd1V6aUpCVSUyQkNvM1ZSelQ4VElQZjBiOTd2dnFEJTJCS0JrbE1RVmZYZUhIQWRLa3dsMjgwRXFWa0hlTE1QM1IlMkZxSUdPcWNCaG5YbnpaQ0hKZ3FDcHVyRzJ0NGslMkY4emF2a3hJNm1XWVVQMSUyRkRldWJYRGhpdlhCTEhHYjdwcHFmTFJ4NlV0WEE4MGdMNklKdGd1bnhwR2JpNEhxd3V3Z2xpNm03eXpGeTBzS3ZqSk55JTJGaUlUWE1jeGlxSEZyZVFHd0lLJTJCZUVNTzl6RGhyZGJCU2NheGJWUXdjRk44Q3hHMU80SFo0eFR2c0hFeXhadUQ0M0Z1JTJCJTJCckVVVUpBQXJaYmZwZ0s5clpybzFkcjVIVEVOSnV5QWs4cWt6d1ZOcThJemh3YkR0VSUzRCZYLUFtei1TaWduYXR1cmU9MjcyNTNjZmE5N2JkMzQyNDY0ZjM5MGVhM2QyODZhYzIyY2YxZWFlMTg2MjQzNDk1NmJiYWMxMjUyODk1OGMzMA"
}

resource "kubernetes_namespace" "todelete" {
  metadata {
    name = "todelete"
  }
}

# provider "helm" {
#   alias = "toolbox-cluster"
#   kubernetes {
#     host                   = data.aws_eks_cluster.cluster.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#     token                  = data.aws_eks_cluster_auth.cluster.token
#   }
# }

# resource "helm_release" "loki_app" {
#   depends_on        = [module.loki_bucket]
#   provider          = helm.toolbox-cluster
#   name              = "loki"
#   chart             = "https://github.com/grafana/helm-charts/releases/download/helm-loki-5.5.1/loki-5.5.1.tgz"
#   atomic            = true
#   cleanup_on_fail   = true
#   reset_values      = true
#   dependency_update = true

#   set {
#     name  = "serviceAccount.name"
#     value = "loki"
#   }

#   set {
#     name  = "serviceAccount.create"
#     value = true
#   }

#   set {
#     name  = "serviceAccount.annotations"
#     value = "[eks.amazonaws.com/role-arn:${module.service_account_can_write_s3.role_arn}]"
#     type  = "auto"
#   }
# }