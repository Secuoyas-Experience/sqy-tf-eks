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
      version = "~> 2.0"
    }
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

provider "aws" {
  region  = "eu-central-1"
}
