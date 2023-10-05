terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.9.0"
    }
  }
}