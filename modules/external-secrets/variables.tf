variable "cluster_name" {
  type = string
}

variable "allowed_secrets_prefix" {
  type        = list(string)
  description = "when using AWS SSM, list of secret name prefixes that the external secrets operator will be allowed to access to"
  default     = []
}

variable "use_ssm" {
  type        = bool
  description = "whether to use AWS SSM or not"
  default     = false
}

variable "helm_version" {
  type        = string
  description = "version of external-secret helm chart version"
  default     = "0.9.5"
}

variable "timeout" {
  type        = number
  description = "helm release timout (sec)"
  default     = 60
}