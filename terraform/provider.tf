data "aws_eks_cluster" "cluster" {
  name = "toolbox"
}

data "aws_eks_cluster_auth" "cluster" {
  depends_on = [data.aws_eks_cluster.cluster]
  name       = data.aws_eks_cluster.cluster.name
}

provider "aws" {
  region = "eu-central-1"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.id]
  #   command     = "aws"
  # }
}

provider "helm" {
  alias = "toolbox-cluster"
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

terraform {
  cloud {
    organization = "secuoyas"

    workspaces {
      name = "toolbox"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.12.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.19.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.9.0"
    }
  }
}

resource "helm_release" "loki_app" {
  provider          = helm.toolbox-cluster
  name              = "loki"
  chart             = "https://github.com/grafana/helm-charts/releases/download/helm-loki-5.5.1/loki-5.5.1.tgz"
  atomic            = true
  cleanup_on_fail   = true
  reset_values      = true
  dependency_update = true

  # set {
  #   name  = "serviceAccount.name"
  #   value = "loki"
  # }

  # set {
  #   name  = "serviceAccount.create"
  #   value = true
  # }

  # set {
  #   name  = "serviceAccount.annotations"
  #   value = "[eks.amazonaws.com/role-arn:${module.service_account_can_write_s3.role_arn}]"
  #   type  = "auto"
  # }
}