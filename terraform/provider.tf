data "aws_eks_cluster" "cluster" {
  name = "toolbox"
}

data "aws_eks_cluster_auth" "cluster" {
  depends_on = [data.aws_eks_cluster.cluster]
  name       = data.aws_eks_cluster.cluster.name
}

provider "aws" {
  region   = "eu-central-1"
}

provider "kubernetes" {
  alias                  = "k8s"
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

resource "kubernetes_namespace" "samples" {
  provider = kubernetes.k8s
  metadata {
    name = "samples"
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