terraform {
  backend "s3" {
    bucket = "griddo-dev-tf-states"
    key    = "griddo-dev"
    region = "eu-west-1"
    #profile = "griddo.dev"
    encrypt = true
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
      version = ">=2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.9.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  #profile = "griddo.dev"
}
