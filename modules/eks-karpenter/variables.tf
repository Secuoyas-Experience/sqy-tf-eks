variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_oidc_provider_arn" {
  type = string
}

variable "addons_karpenter_version" {
  type        = string
  description = "Karpenter Helm Chart version"
}

variable "addon_timeout" {
  type        = number
  description = "helm release timout (sec)"
  default     = 60
}

variable "karpenter_volumeSize" {
  type        = string
  description = "Nodeclass VolumeSize"
}

variable "irsa_namespace_service_accounts" {
  description = "List of `namespace:serviceaccount`pairs to use in trust policy for IAM role for service accounts"
  type        = list(string)
}

variable "addons_karpenter_volumeType" {
  type        = string
  description = "Nodeclass VolumeType"
}

variable "addons_karpenter_volumeIops" {
  type        = number
  description = "Nodeclass VolumeIops"
}

variable "addons_karpenter_namespace" {
  type        = string
  description = "Karpenter namespace"
}