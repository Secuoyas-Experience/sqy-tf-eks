variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_oidc_provider_arn" {
  type = string
}

variable "addon_version" {
  type    = string
  default = "v0.34.0"
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
