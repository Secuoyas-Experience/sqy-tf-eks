terraform {
  required_version = ">= 1.5"

  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.34.0"
    }
  }
}
