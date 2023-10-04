variable "cluster_name" {
  type = string
}

variable "cluster_oidc_provider_arn" {
  type = string
}

variable "helm_version" {
  type        = string
  description = "helm chart version"
  default     = "1.5.4"
}