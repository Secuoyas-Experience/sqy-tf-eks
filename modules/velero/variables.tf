variable "velero" {
  description = "Velero add-on configuration values"
  type        = any
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "oidc_provider_arn" {
  description = "The ARN of the cluster OIDC Provider"
  type        = string
}