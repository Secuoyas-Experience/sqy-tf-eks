module "ebs_csi_driver_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.33.0"

  role_name_prefix      = "${module.cluster_eks.cluster_name}-ebs-csi-driver-"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.cluster_eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

module "eks_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.12.0"

  cluster_name      = module.cluster_eks.cluster_name
  cluster_endpoint  = module.cluster_eks.cluster_endpoint
  cluster_version   = module.cluster_eks.cluster_version
  oidc_provider_arn = module.cluster_eks.oidc_provider_arn

  enable_metrics_server   = true
  enable_external_dns     = true
  enable_external_secrets = true
  enable_argocd           = true
  enable_argo_events      = true
  enable_cert_manager     = true

  ################################## 
  ######### AWS EKS ADDONS #########
  ##################################
  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_driver_irsa.iam_role_arn
      configuration_values = jsonencode({
        sidecars = {
          snapshotter = {
            forceEnable = false
          }
        }
      })
    }
    coredns = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
  }

  external_dns_route53_zone_arns = [for k, v in module.zones.route53_zone_zone_arn : v]

  eks_addons_timeouts = {
    create = "${var.addons_helm_timeout}s"
  }

  ################################## 
  ######### OSS EKS ADDONS #########
  ##################################
  argocd = {
    chart_version = var.addons_argocd_version
    timeout       = var.addons_helm_timeout
    wait          = false
  }

  argo_events = {
    chart_version = var.addons_argo_events_version
    timeout       = var.addons_helm_timeout
    wait          = false
  }

  external_secrets = {
    chart_version = var.addons_external_secrets_version
    timeout       = var.addons_helm_timeout
    wait          = false
  }

  metrics_server = {
    timeout = var.addons_helm_timeout
    wait    = false
  }

  external_dns = {
    timeout = var.addons_helm_timeout
    wait    = false
    set = [
      {
        name  = "policy"
        value = "sync"
      }
    ]
  }

  cert_manager = {
    chart_version = var.addons_cert_manager_version
    timeout       = var.addons_helm_timeout
    wait          = false
  }
}

module "karpenter" {
  source                    = "./modules/karpenter"
  helm_version              = var.addons_karpenter_version
  cluster_name              = module.cluster_eks.cluster_name
  cluster_endpoint          = module.cluster_eks.cluster_endpoint
  cluster_oidc_provider_arn = module.cluster_eks.oidc_provider_arn
  node_group_name           = "inception"
}

module "eks-aws-load-balancer" {
  source                    = "./modules/aws-load-balancer"
  cluster_name              = module.cluster_eks.cluster_name
  cluster_oidc_provider_arn = module.cluster_eks.oidc_provider_arn
  helm_version              = var.addons_aws_load_balancer_version
  depends_on                = [module.karpenter]
}

resource "helm_release" "reloader" {
  name       = "stakater"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = var.addons_reloader_version
  timeout    = var.addons_helm_timeout
  depends_on = [module.eks-aws-load-balancer]
}