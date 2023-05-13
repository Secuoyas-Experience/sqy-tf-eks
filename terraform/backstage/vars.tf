variable "domain" {
  type        = string
  description = "name of the domain where the cluster will be exposed"
}

variable "allowed_org_repo_list" {
  type        = list(string)
  description = "list of org/repo pairs allowed to upload files to S3"
}

variable "oidc_arn" {
  type        = string
  description = "arn of the oidc provider required in this module"
}

variable "backstage_doppler_token" {
  type        = string
  description = "Doppler token to sync aws values to Doppler"
  sensitive   = true
}