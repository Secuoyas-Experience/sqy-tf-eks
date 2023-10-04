# module "karpenter" {
#   source                    = "./modules/eks-karpenter"
#   helm_version              = var.addons_karpenter_version
#   cluster_name              = module.cluster_eks.cluster_name
#   cluster_endpoint          = module.cluster_eks.cluster_endpoint
#   cluster_oidc_provider_arn = module.cluster_eks.oidc_provider_arn
#   node_group_name           = "inception"
#   provisioners_dir          = "manifests/karpenter"
# }

resource "helm_release" "argocd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.addons_argocd_version
  create_namespace = true
  depends_on       = [module.cluster_eks]
}

module "eks-aws-load-balancer" {
  source                    = "./modules/eks-aws-load-balancer"
  cluster_name              = module.cluster_eks.cluster_name
  cluster_oidc_provider_arn = module.cluster_eks.oidc_provider_arn
  helm_version              = var.addons_aws_load_balancer_version
  depends_on                = [module.cluster_eks]
}

module "external-secrets" {
  source       = "./modules/eks-external-secrets"
  cluster_name = module.cluster_eks.cluster_name
  helm_version = var.addons_external_secrets_version
  depends_on   = [module.cluster_eks]
}

resource "helm_release" "reloader" {
  name       = "stakater"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = var.addons_reloader_version
  depends_on = [module.cluster_eks]
}