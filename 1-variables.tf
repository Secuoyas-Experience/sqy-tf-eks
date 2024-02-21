variable "cluster_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC cidr"
}

variable "cluster_azs" {
  type        = list(string)
  description = "VPC azs"
}

variable "inception_desired_size" {
  type        = number
  description = "number of desired cluster node group instances"
  default     = 1
}

variable "inception_min_size" {
  type        = number
  description = "number of min cluster node group instances"
  default     = 1
}

variable "inception_max_size" {
  type        = number
  description = "number of max cluster node group instances"
  default     = 1
}

variable "inception_types" {
  type        = list(string)
  description = "list of types of initial cluster node group instances"
  default     = ["t3a.medium"]
}

variable "cluster_private_subnets" {
  type        = list(string)
  description = "VPC private subnets. Normally used by nodes and pods"
}

variable "cluster_public_subnets" {
  type        = list(string)
  description = "VPC public subnets. Normally used by the AWS load balancers to expose services"
}

variable "cluster_domains" {
  type        = list(string)
  description = "Domain names handled by this cluster. Normally the NS domain name where ingresses are under (e.g dev.mycompany.com)"
  default     = []
}

variable "cluster_domains_zones_arns" {
  type        = list(string)
  default     = []
  description = "Zone arns. Should be provided by another resource. If you want this module to create them use cluster_domains variable"
}

variable "cluster_region" {
  type        = string
  description = "AWS region where the EKS cluster is located"
}

variable "cluster_name" {
  type        = string
  description = "AWS EKS cluster name"
}

variable "cluster_kubernetes_version" {
  type        = string
  description = "Cluster kubernetes version"
  default     = "1.29"
}

variable "organization" {
  type        = string
  description = "Organization the cluster is used for"
}

variable "environment" {
  type        = string
  description = "Type of environment (dev,stg,prod)"
}

variable "access_entries" {
  type = any
  description = "EKS access entries (https://docs.aws.amazon.com/eks/latest/userguide/access-entries.html)"
  default = {}
}