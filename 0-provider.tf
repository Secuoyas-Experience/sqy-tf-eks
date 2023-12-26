terraform {
  backend "s3" {
    bucket  = "griddo-dev-tf-states"
    key     = "griddo-dev"
    region  = "eu-west-1"
    encrypt = true
  }

  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
