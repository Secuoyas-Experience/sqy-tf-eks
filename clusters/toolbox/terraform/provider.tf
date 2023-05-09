provider "aws" {
  region = "eu-central-1"
  profile = "toolbox.secuoyas.com"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.12.0"
    }
  }
}