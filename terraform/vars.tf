variable "backstage_doppler_token" {
  type        = string
  description = "Doppler token to set Doppler secrets from Terraform execution"
  sensitive   = true
}