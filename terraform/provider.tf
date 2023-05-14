provider "aws" {
  region = "eu-central-1"
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
