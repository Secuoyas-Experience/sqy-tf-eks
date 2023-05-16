# terraform {
#   required_providers {
#     kubectl = {
#       source  = "gavinbunney/kubectl"
#       version = ">= 1.14.0"
#     }
#   }
# }

# provider "kubectl" {
#   host                   = module.eks-blueprints.aws_eks_cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks-blueprints.aws_eks_cluster_certificate_authority_data)
#   token                  = module.eks-blueprints.aws_eks_cluster_token
# }

# module "karpenter" {
#   source  = "terraform-aws-modules/eks/aws//modules/karpenter"
#   version = "19.10.0"

#   cluster_name           = module.eks_blueprints.eks_cluster_id
#   irsa_oidc_provider_arn = module.eks_blueprints.eks_oidc_provider_arn
#   create_irsa            = false # IRSA will be created by the kubernetes-addons module
# }

# resource "kubectl_manifest" "karpenter_provisioner" {
#     yaml_body = file("")
#     depends_on = [module.kubernetes_addons]
# }

# resource "kubectl_manifest" "karpenter_template" {
#     yaml_body = file("")
#     depends_on = [module.kubernetes_addons]
# }