terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31.0"
    }
  }
}

data "kubectl_path_documents" "extra_storage_classes_path" {
  pattern = "${var.extra_storage_classes_path}/*.yaml"
}

resource "kubectl_manifest" "storageClasses-yaml" {
  for_each  = data.kubectl_path_documents.extra_storage_classes_path.manifests
  yaml_body = each.value
}