########################################
############## KARPENTER ###############
########################################

module "karpenter" {
  source                    = "../eks-karpenter"
  cluster_name              = var.cluster_name
  cluster_endpoint          = var.cluster_endpoint
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
}

########################################
################ VELERO ################
########################################

module "velero" {
  source            = "../eks-velero"
  s3_backup_arn     = var.addons_velero_bucket_arn
  oidc_provider_arn = var.cluster_oidc_provider_arn
  timeout           = var.addons_helm_timeout

  depends_on = [
    module.karpenter.karpenter_default_nodepool,
    module.karpenter.karpenter_default_nodeclass,
  ]
}

########################################
############## RELOADER ################
########################################

resource "helm_release" "reloader" {
  name             = "stakater"
  repository       = "https://stakater.github.io/stakater-charts"
  chart            = "reloader"
  wait             = false
  disable_webhooks = true
  version          = "1.0.56"
  timeout          = var.addons_helm_timeout

  depends_on = [
    module.karpenter.karpenter_default_nodepool,
    module.karpenter.karpenter_default_nodeclass,
  ]
}

########################################
############## REMAINING ###############
########################################

module "eks_addons_extra" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.15.1"

  cluster_name      = var.cluster_name
  cluster_endpoint  = var.cluster_endpoint
  cluster_version   = var.cluster_version
  oidc_provider_arn = var.cluster_oidc_provider_arn

  enable_metrics_server               = true
  enable_external_dns                 = true
  enable_aws_load_balancer_controller = true
  enable_external_secrets             = true
  enable_cert_manager                 = var.addons_cert_manager_enabled
  enable_aws_efs_csi_driver           = var.addons_aws_efs_csi_driver_enabled
  enable_argocd                       = var.addons_argocd_enabled
  enable_argo_events                  = var.addons_argo_events_enabled

  external_dns_route53_zone_arns = var.cluster_domains_zones_arns

  cert_manager = {
    chart_version    = coalesce(var.addons_cert_manager_version, "v1.14.2")
    timeout          = var.addons_helm_timeout
    disable_webhooks = true
  }

  aws_load_balancer_controller = {
    chart_version    = coalesce(var.addons_aws_load_balancer_version, "1.6.2")
    timeout          = var.addons_helm_timeout
    disable_webhooks = true
    set              = [{ name = "enableServiceMutatorWebhook", value = "false" }]
  }

  external_secrets = {
    chart_version = coalesce(var.addons_external_secrets_version, "0.9.11")
    timeout       = var.addons_helm_timeout
  }

  metrics_server = {
    chart_version = coalesce(var.addons_metrics_server_version, "3.12.0")
    timeout       = var.addons_helm_timeout
  }

  external_dns = {
    chart_version = coalesce(var.addons_external_dns_version, "1.14.3")
    timeout       = var.addons_helm_timeout
    set           = [{ name = "policy", value = "sync" }]
  }

  argocd = {
    chart_version = coalesce(var.addons_argocd_version, "5.46.7")
    timeout       = var.addons_helm_timeout
    wait          = false
  }

  argo_events = {
    chart_version = coalesce(var.addons_argo_events_version, "2.4.1")
    timeout       = var.addons_helm_timeout
    wait          = false
  }

  depends_on = [
    module.karpenter.karpenter_default_nodepool,
    module.karpenter.karpenter_default_nodeclass,
  ]
}