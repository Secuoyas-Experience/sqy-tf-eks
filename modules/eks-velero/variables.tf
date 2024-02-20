variable "velero" {
  description = "Velero add-on configuration values"
  type        = any
  default     = {}
}

variable "s3_backup_arn" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "timeout" {
  type = number
}

variable "wait" {
  type    = bool
  default = false
}

variable "wait_for_jobs" {
  type    = bool
  default = false
}

variable "disable_webhooks" {
  type    = bool
  default = true
}