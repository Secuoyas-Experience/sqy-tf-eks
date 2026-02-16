########################################
############## KARPENTER ###############
########################################

module "karpenter" {
  source                    = "../eks-karpenter"
  cluster_name              = var.cluster_name
  cluster_endpoint          = var.cluster_endpoint
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  karpenter_volumeSize      = var.addons_karpenter_volumeSize
}

########################################
################ VELERO ################
########################################

module "velero" {
  source            = "../eks-velero"
  count             = var.addons_velero_enabled ? 1 : 0
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
  count            = var.addons_reloader_enabled ? 1 : 0
  name             = "stakater"
  repository       = "https://stakater.github.io/stakater-charts"
  chart            = "reloader"
  wait             = false
  disable_webhooks = true
  version          = var.addons_reloader_chart_version
  timeout          = var.addons_helm_timeout
  set {
    name  = "reloader.deployment.image.name"
    value = var.addons_reloader_image_repository
  }

  set {
    name  = "reloader.deployment.image.tag"
    value = var.addons_reloader_image_repository_tag
  }

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
  version = "1.20.0"

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
    chart_version    = coalesce(var.addons_cert_manager_version)
    timeout          = var.addons_helm_timeout
    disable_webhooks = true
    set = [
      { name = "image.repository", value = var.addons_cert_manager_image_repository[0] },
      { name = "image.tag", value = var.addons_cert_manager_image_repository_tag },
      { name = "cainjector.image.repository", value = var.addons_cert_manager_image_repository[1] },
      { name = "cainjector.image.tag", value = var.addons_cert_manager_image_repository_tag },
      { name = "webhook.image.repository", value = var.addons_cert_manager_image_repository[2] },
      { name = "webhook.image.tag", value = var.addons_cert_manager_image_repository_tag }
    ]
  }

  aws_load_balancer_controller = {
    chart_version    = coalesce(var.addons_aws_load_balancer_version)
    timeout          = var.addons_helm_timeout
    disable_webhooks = true
    set = [
      { name = "enableServiceMutatorWebhook", value = "false" },
      { name = "image.repository", value = var.addons_aws_load_balancer_image_repository },
      { name = "image.tag", value = var.addons_aws_load_balancer_image_repository_tag }
    ]
    policy_statements = [
      {
        effect    = "Allow"
        actions   = ["elasticloadbalancing:SetRulePriorities"]
        resources = ["*"]
      }
    ]
  }

  external_secrets = {
    chart_version = coalesce(var.addons_external_secrets_version)
    timeout       = var.addons_helm_timeout
    set = [
      { name = "image.repository", value = var.addons_external_secrets_image_repository },
      { name = "image.tag", value = var.addons_external_secrets_image_repository_tag },
      { name = "webhook.image.repository", value = var.addons_external_secrets_image_repository },
      { name = "webhook.image.tag", value = var.addons_external_secrets_image_repository_tag },
      { name = "certController.image.repository", value = var.addons_external_secrets_image_repository },
      { name = "certController.image.tag", value = var.addons_external_secrets_image_repository_tag }
    ]
    role_policies = {
      ecr = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
    }
  }

  metrics_server = {
    chart_version = coalesce(var.addons_metrics_server_version)
    timeout       = var.addons_helm_timeout
    set = [
      { name = "image.repository", value = var.addons_metrics_server_image_repository },
      { name = "image.tag", value = var.addons_metrics_server_image_repository_tag }
    ]
  }

  external_dns = {
    chart_version = coalesce(var.addons_external_dns_version)
    timeout       = var.addons_helm_timeout
    set = [
      { name = "policy", value = "sync" },
      { name = "image.repository", value = var.addons_external_dns_image_repository },
      { name = "image.tag", value = var.addons_external_dns_image_repository_tag }
    ]
  }

  argocd = {
    chart_version = coalesce(var.addons_argocd_version)
    timeout       = var.addons_helm_timeout
    wait          = false
    set = flatten([
      [
        { name = "global.domain", value = var.addons_argocd_server_ingress_host },
        { name = "global.image.repository", value = var.addons_argocd_image_repository },
        { name = "global.image.tag", value = var.addons_argocd_image_repository_tag },
        { name = "redis.image.repository", value = var.addons_argocd_redis_image_repository },
        { name = "redis.image.tag", value = var.addons_argocd_redis_image_repository_tag },
        { name = "dex.image.repository", value = var.addons_argocd_dex_image_repository },
        { name = "dex.image.tag", value = var.addons_argocd_dex_image_repository_tag },
        { name = "configs.params.server\\.insecure", value = true },
        { name = "configs.params.redis\\.server", value = "argo-cd-argocd-redis:6379" },
        { name = "configs.params.repo\\.server", value = "argo-cd-argocd-repo-server:8081" },
        { name = "configs.params.server\\.dex\\.server", value = "https://argo-cd-argocd-dex-server:5556" },
      ],
      var.addons_argocd_server_ingress_enabled ? [
        { name  = "server.ingress.enabled",
          value = var.addons_argocd_server_ingress_enabled
        },
        { name  = "server.ingress.hosts[0]",
          value = var.addons_argocd_server_ingress_host
        },
        { name  = "server.ingress.ingressClassName",
          value = "alb"
        },
        { name  = "server.ingress.tls[0].hosts[0]",
          value = var.addons_argocd_server_ingress_host,
        },
        { name  = "server.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/scheme",
          value = "internal"
        },
        { name  = "server.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/target-type",
          value = "ip"
        },
        { name  = "server.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/listen-ports",
          value = "[{\"HTTPS\":443}]"
        },
        { name  = "server.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/ssl-redirect",
          value = "443"
        },
        { name  = "server.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/group\\.name",
          value = "internal-tools"
        },
      ] : [],
      length(var.addons_argocd_az) > 0 ? [
        { name = "controller.nodeSelector.topology\\.kubernetes\\.io/zone", value = var.addons_argocd_az },
        { name = "dex.nodeSelector.topology\\.kubernetes\\.io/zone", value = var.addons_argocd_az },
        { name = "redis.nodeSelector.topology\\.kubernetes\\.io/zone", value = var.addons_argocd_az },
        { name = "repoServer.nodeSelector.topology\\.kubernetes\\.io/zone", value = var.addons_argocd_az },
        { name = "server.nodeSelector.topology\\.kubernetes\\.io/zone", value = var.addons_argocd_az },
        { name = "applicationSet.nodeSelector.topology\\.kubernetes\\.io/zone", value = var.addons_argocd_az },
        { name = "notifications.nodeSelector.topology\\.kubernetes\\.io/zone", value = var.addons_argocd_az },
      ] : []
    ])
  }

  argo_events = {
    chart_version = coalesce(var.addons_argo_events_version)
    timeout       = var.addons_helm_timeout
    wait          = false
  }

  aws_efs_csi_driver = {
    chart_version = coalesce(var.addons_aws_efs_csi_driver_version)
    timeout       = var.addons_helm_timeout
    set = [
      { name = "image.repository", value = var.addons_aws_efs_csi_driver_image_repository["controller"] },
      { name = "image.tag", value = var.addons_aws_efs_csi_driver_image_repository_tag["controller"] },
      { name = "sidecars.livenessProbe.image.repository", value = var.addons_aws_efs_csi_driver_image_repository["livenessProbe"] },
      { name = "sidecars.livenessProbe.image.tag", value = var.addons_aws_efs_csi_driver_image_repository_tag["livenessProbe"] },
      { name = "sidecars.nodeDriverRegistrar.image.repository", value = var.addons_aws_efs_csi_driver_image_repository["nodeDriverRegistrar"] },
      { name = "sidecars.nodeDriverRegistrar.image.tag", value = var.addons_aws_efs_csi_driver_image_repository_tag["nodeDriverRegistrar"] },
      { name = "sidecars.csiProvisioner.image.repository", value = var.addons_aws_efs_csi_driver_image_repository["csiProvisioner"] },
      { name = "sidecars.csiProvisioner.image.tag", value = var.addons_aws_efs_csi_driver_image_repository_tag["csiProvisioner"] }
    ]
  }

  depends_on = [
    module.karpenter.karpenter_default_nodepool,
    module.karpenter.karpenter_default_nodeclass,
  ]
}
