terraform {
  required_version = ">= 1.5"

  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.11.0"
    }
  }
}