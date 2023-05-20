terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

provider "kubectl" {
  host                   = module.eks_blueprints.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_blueprints.cluster_certificate_authority_data)
  # token                  = data.aws_eks_cluster_auth.cluster.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks_blueprints.cluster_name]
    command     = "aws"
  }
}

# we need to use this module in order to (among other things) to
# get the instance profile we need to add to aws_auth
module "karpenter" {
  source                 = "terraform-aws-modules/eks/aws//modules/karpenter"
  version                = "19.12.0"
  cluster_name           = module.eks_blueprints.cluster_name
  irsa_oidc_provider_arn = module.eks_blueprints.oidc_provider_arn
  create_irsa            = false # IRSA will be created by the kubernetes-addons module
}

# karpenter default provisioner
resource "kubectl_manifest" "karpenter_provisioner" {
  yaml_body = file("${path.module}/manifests/karpenter/provisioner.yaml")

  depends_on = [
    module.kubernetes_addons
  ]
}

# karpenter default new node instance template
resource "kubectl_manifest" "karpenter_template" {
  yaml_body = templatefile("${path.module}/manifests/karpenter/aws-node-template.yaml", {
    cluster_name          = module.eks_blueprints.cluster_name
    instance_profile_name = module.karpenter.instance_profile_name
  })

  depends_on = [
    module.kubernetes_addons
  ]
}