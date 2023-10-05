variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_oidc_provider_arn" {
  type = string
}

variable "node_group_name" {
  type        = string
  description = "the node group name where install karpenter. Should be different than a node create by karpenter."
}

variable "helm_version" {
  type    = string
  default = "v0.31.0"
}

variable "timeout" {
  type        = number
  description = "helm release timout (sec)"
  default     = 60
}

variable "provisioners_dir" {
  type        = string
  description = "directory where manifests of provisioners can be found"
}