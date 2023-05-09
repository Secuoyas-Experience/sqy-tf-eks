provider "aws" {
  region  = "eu-central-1"
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
  }
}