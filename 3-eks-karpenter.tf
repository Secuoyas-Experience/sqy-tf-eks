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

module "karpenter" {
  source                 = "terraform-aws-modules/eks/aws//modules/karpenter"
  version                = "19.14.0"
  cluster_name           = module.eks_blueprints.cluster_name
  irsa_oidc_provider_arn = module.eks_blueprints.oidc_provider_arn
  create_irsa            = true                    # IRSA will be created by the kubernetes-addons module
  irsa_tag_key           = "kubernetes.io/cluster" # IAM has to have an entry with this key and the cluster_name as value
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true
  name             = "karpenter"
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter"
  version          = "v0.27.5"

  set {
    name  = "settings.aws.clusterName"
    value = module.eks_blueprints.cluster_name
  }

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.karpenter.irsa_arn
  }

  set {
    name  = "settings.aws.clusterEndpoint"
    value = module.eks_blueprints.cluster_endpoint
  }

  set {
    name  = "settings.aws.defaultInstanceProfile"
    value = module.karpenter.instance_profile_name
  }

  set {
    name  = "settings.aws.interruptionQueueName"
    value = module.karpenter.queue_name
  }

  depends_on = [
    module.eks_blueprints,
    module.karpenter
  ]
}

# webhook doesn't pickup and I can't set the liveProbeness
# to last longer so that's why I'm creating a terraform
# timeout
resource "time_sleep" "wait_30_secs_after_helm_karpenter" {
  depends_on      = [helm_release.karpenter]
  create_duration = "30s"
}

# karpenter default provisioner
resource "kubectl_manifest" "karpenter_provisioner" {
  yaml_body  = file("${path.module}/manifests/karpenter/provisioner.yaml")
  depends_on = [time_sleep.wait_30_secs_after_helm_karpenter]
}

# karpenter default new node instance template
resource "kubectl_manifest" "karpenter_template" {
  yaml_body = templatefile("${path.module}/manifests/karpenter/aws-node-template.yaml", {
    cluster_name          = module.eks_blueprints.cluster_name
    instance_profile_name = module.karpenter.instance_profile_name
  })

  depends_on = [time_sleep.wait_30_secs_after_helm_karpenter]
}