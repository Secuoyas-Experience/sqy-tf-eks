module "karpenter" {
  source                    = "./modules/karpenter"
  helm_version              = var.addons_karpenter_version
  timeout                   = var.addons_helm_timeout
  cluster_name              = module.cluster_eks.cluster_name
  cluster_endpoint          = module.cluster_eks.cluster_endpoint
  cluster_oidc_provider_arn = module.cluster_eks.oidc_provider_arn
  node_group_name           = "inception"
  provisioners_dir          = "manifests/karpenter"
}

module "eks-aws-load-balancer" {
  source                    = "./modules/aws-load-balancer"
  helm_version              = var.addons_aws_load_balancer_version
  timeout                   = var.addons_helm_timeout
  cluster_name              = module.cluster_eks.cluster_name
  cluster_oidc_provider_arn = module.cluster_eks.oidc_provider_arn
  depends_on                = [module.karpenter]
}

module "external-secrets" {
  source       = "./modules/external-secrets"
  helm_version = var.addons_external_secrets_version
  timeout      = var.addons_helm_timeout
  cluster_name = module.cluster_eks.cluster_name
  depends_on   = [module.eks-aws-load-balancer]
}

resource "helm_release" "reloader" {
  name       = "stakater"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = var.addons_reloader_version
  timeout    = var.addons_helm_timeout
  depends_on = [module.external-secrets]
}

resource "helm_release" "argocd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.addons_argocd_version
  timeout          = var.addons_helm_timeout
  namespace        = "argocd"
  create_namespace = true
  depends_on       = [helm_release.reloader]
}

