terraform {
  required_version = ">= 1.5"

  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.1.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.89.0"
    }
  }
}
