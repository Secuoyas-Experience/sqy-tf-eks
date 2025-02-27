variable "cluster_name" {
  type        = string
  description = "AWS EKS cluster name"
}

variable "cluster_oidc_provider_arn" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_domains_zones_arns" {
  type        = list(string)
  default     = []
  description = "Zone arns. Should be provided by another resource. If you want this module to create them use cluster_domains variable"
}

variable "addons_helm_timeout" {
  type        = number
  description = "helm release timeout seconds (default 1800 sec -> 30 min)"
  default     = 1800
}

variable "addons_karpenter_version" {
  type        = string
  description = "Karpenter Helm Chart version"
  default     = "v0.34.0"
}

variable "addons_karpenter_nodepools_path" {
  type        = string
  description = "Karpenter's provisioners path"
  default     = ""
}

variable "addons_karpenter_volumeSize" {
  type        = string
  description = "Karpenter's volumeSize"
  default     = "10Gi"
}

variable "addons_argocd_version" {
  type        = string
  description = "ArgoCD Helm Chart version"
  default     = "5.46.7"
}

variable "addons_argocd_enabled" {
  type        = bool
  default     = false
  description = "if true ArgoCD is enabled"
}

variable "addons_external_secrets_version" {
  type    = string
  default = "0.9.11"
}

variable "addons_metrics_server_version" {
  type    = string
  default = "3.12.0"
}

variable "addons_external_dns_version" {
  type    = string
  default = "1.14.3"
}

# https://github.com/argoproj/argo-helm/tree/main/charts/argo-events
variable "addons_argo_events_version" {
  type        = string
  description = "Argo Events Helm Chart version"
  default     = "2.4.1"
}

variable "addons_argo_events_enabled" {
  type        = bool
  description = "if true argo-events is enabled"
  default     = false
}

variable "addons_aws_load_balancer_version" {
  type        = string
  description = "EKS AWS Load Balancer Helm Chart version"
  default     = "1.6.2"
}

variable "addons_reloader_version" {
  type        = string
  description = "Stakater Reloader Helm Chart version"
  default     = "1.0.56"
}

variable "addons_cert_manager_version" {
  type        = string
  description = "Cert Manager operator Helm Chart version"
  default     = "1.13.3"
}

variable "addons_cert_manager_enabled" {
  type        = bool
  default     = true
  description = "if true cert-manager is enabled"
}

variable "addons_velero_enabled" {
  type        = bool
  default     = false
  description = "Enable velero (enabled by default)"
}

variable "addons_velero_version" {
  type        = string
  description = "Velervar.cluster_nameo Helm Chart version"
  default     = "4.0.3"
}

variable "addons_velero_bucket_arn" {
  type        = string
  description = "if addons_velero_create_bucket is false then we need to provide the bucket arn"
  default     = null
}

variable "addons_helm_repository_username" {
  type        = string
  description = "credentials (username) for helm repositories hosted in github.com"
  default     = null
}

variable "addons_helm_repository_password" {
  type        = string
  description = "credentials (password) for helm repositories hosted in github.com"
  default     = null
}

variable "addons_aws_efs_csi_driver_enabled" {
  type        = bool
  description = "if true aws-efs-csi-driver is enabled"
  default     = false
}

variable "addons_aws_efs_csi_driver_version" {
  type        = string
  description = "AWS EFS CSI Driver Helm Chart version"
}