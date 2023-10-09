variable "cluster_domain" {
  type        = string
  description = "DNS Host Zone. Normally the NS domain name where ingresses are under (e.g dev.mycompany.com)"
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
  default     = "1.27"
}

variable "organization" {
  type        = string
  description = "Organization the cluster is used for"
}

variable "environment" {
  type        = string
  description = "Type of environment (dev,stg,prod)"
}

variable "addons_helm_timeout" {
  type        = number
  description = "helm release timeout seconds (default 1200 sec -> 20 min)"
  default     = 1500
}

variable "addons_velero_version" {
  type        = string
  description = "Velero Helm Chart version"
  default     = "4.0.3"
}

variable "addons_karpenter_version" {
  type        = string
  description = "Karpenter Helm Chart version"
  default     = "v0.31.0"
}

variable "addons_argocd_version" {
  type        = string
  description = "ArgoCD Helm Chart version"
  default     = "5.46.7"
}

# https://github.com/argoproj/argo-helm/tree/main/charts/argo-events
variable "addons_argo_events_version" {
  type        = string
  description = "Argo Events Helm Chart version"
  default     = "2.4.1"
}

variable "addons_aws_load_balancer_version" {
  type        = string
  description = "EKS AWS Load Balancer Helm Chart version"
  default     = "1.6.1"
}

variable "addons_external_secrets_version" {
  type        = string
  description = "External Secrets Helm Chart version"
  default     = "0.9.5"
}

variable "addons_reloader_version" {
  type        = string
  description = "Stakater Reloader Helm Chart version"
  default     = "1.0.42"
}