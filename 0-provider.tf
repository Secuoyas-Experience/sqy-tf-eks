terraform {
  cloud {
    organization = "secuoyas"
    workspaces {
      name = "toolbox"
    }
  }
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">=1.14.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.9.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
}