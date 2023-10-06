terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.19.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.11.0"
    }
  }
}