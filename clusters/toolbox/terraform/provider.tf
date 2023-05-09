provider "aws" {
  region  = "eu-central-1"
  profile = "toolbox.secuoyas.com"
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