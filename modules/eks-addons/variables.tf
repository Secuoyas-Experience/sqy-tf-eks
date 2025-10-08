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

variable "addons_external_secrets_image_repository" {
  type        = string
  description = "External Secrets image repository"
  default     = "oci.external-secrets.io/external-secrets/external-secrets"
}

variable "addons_external_secrets_image_repository_tag" {
  type        = string
  description = "External Secrets image tag"
  default     = "v0.14.2"
}

variable "addons_metrics_server_version" {
  type    = string
  default = "3.12.0"
}

variable "addons_metrics_server_image_repository" {
  type        = string
  description = "Metrics Server image repository"
  default     = "registry.k8s.io/metrics-server/metrics-server"
}

variable "addons_metrics_server_image_repository_tag" {
  type        = string
  description = "Metrics Server image tag"
  default     = "v0.7.2"
}

variable "addons_external_dns_version" {
  type    = string
  default = "1.14.3"
}

variable "addons_external_dns_image_repository" {
  type        = string
  description = "External DNS image repository"
  default     = "registry.k8s.io/external-dns/external-dns"
}

variable "addons_external_dns_image_repository_tag" {
  type        = string
  description = "External DNS image tag"
  default     = "v0.15.1"
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

variable "addons_argocd_image_repository" {
  type        = string
  description = "ArgoCD image repository"
  default     = "quay.io/argoproj/argocd"
}

variable "addons_argocd_image_repository_tag" {
  type        = string
  description = "ArgoCD image tag"
  default     = "v2.8.7"
}

variable "addons_argocd_redis_image_repository" {
  type        = string
  description = "ArgoCD redis image repository"
  default     = "public.ecr.aws/docker/library/redis"
}

variable "addons_argocd_redis_image_repository_tag" {
  type        = string
  description = "ArgoCD redis image tag"
  default     = "7.0.13-alpine"
}

variable "addons_argocd_dex_image_repository" {
  type        = string
  description = "ArgoCD dex image repository"
  default     = "ghcr.io/dexidp/dex"
}

variable "addons_argocd_dex_image_repository_tag" {
  type        = string
  description = "ArgoCD dex image tag"
  default     = "v2.37.0"
}

variable "addons_argocd_server_ingress_enabled" {
  type        = bool
  description = "if true ArgoCD server ingress is enabled"
  default     = true
}

variable "addons_argocd_server_ingress_host" {
  type        = string
  description = "ArgoCD server ingress host"
}

variable "addons_aws_load_balancer_version" {
  type        = string
  description = "EKS AWS Load Balancer Helm Chart version"
  default     = "1.6.2"
}

variable "addons_aws_load_balancer_image_repository" {
  type        = string
  description = "Load Balancer image repository"
  default     = "public.ecr.aws/eks/aws-load-balancer-controller"
}

variable "addons_aws_load_balancer_image_repository_tag" {
  type        = string
  description = "Load Balancer image tag"
  default     = "v2.11.0"
}

variable "addons_reloader_version" {
  type        = string
  description = "Stakater Reloader Helm Chart version"
  default     = "1.0.56"
}

variable "addons_reloader_enabled" {
  description = "Enable Stakater Reloader"
  type        = bool
  default     = false
}

variable "addons_reloader_chart_version" {
  type        = string
  description = "Reloader Helm Chart version"
  default     = "1.0.56"
}

variable "addons_reloader_image_repository" {
  type        = string
  description = "Reloader image repository"
  default     = "ghcr.io/stakater/reloader"
}

variable "addons_reloader_image_repository_tag" {
  type        = string
  description = "Reloader image tag"
  default     = "v1.0.56"
}

variable "addons_cert_manager_version" {
  type        = string
  description = "Cert Manager operator Helm Chart version"
  default     = "1.13.3"
}

variable "addons_cert_manager_image_repository" {
  type        = list(string)
  description = "Cert Manager image repository"
  default = [
    "quay.io/jetstack/cert-manager-controller",
    "quay.io/jetstack/cert-manager-cainjector",
    "quay.io/jetstack/cert-manager-webhook"
  ]
}

variable "addons_cert_manager_image_repository_tag" {
  type        = string
  description = "Cert Manager image tag"
  default     = "v1.17.1"
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

variable "addons_aws_efs_csi_driver_image_repository" {
  type        = map(string)
  description = "EFS CSI Driver image repository"
  default = {
    controller          = "public.ecr.aws/efs-csi-driver/amazon/aws-efs-csi-driver",
    livenessProbe       = "public.ecr.aws/eks-distro/kubernetes-csi/livenessprobe",
    nodeDriverRegistrar = "public.ecr.aws/eks-distro/kubernetes-csi/node-driver-registrar",
    csiProvisioner      = "public.ecr.aws/eks-distro/kubernetes-csi/external-provisioner"
  }
}

variable "addons_aws_efs_csi_driver_image_repository_tag" {
  type        = map(string)
  description = "AWS EFS CSI Driver image tag"
  default = {
    controller          = "v2.1.6",
    livenessProbe       = "v2.14.0-eks-1-31-5",
    nodeDriverRegistrar = "v2.12.0-eks-1-31-5",
    csiProvisioner      = "v5.1.0-eks-1-31-5"
  }
}
