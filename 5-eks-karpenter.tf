module "karpenter" {
  source                 = "terraform-aws-modules/eks/aws//modules/karpenter"
  version                = "19.14.0"
  cluster_name           = module.eks_blueprints.cluster_name
  irsa_oidc_provider_arn = module.eks_blueprints.oidc_provider_arn
  create_irsa            = true
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

# karpenter default new node instance template
resource "kubectl_manifest" "karpenter_template" {
  yaml_body = templatefile("${path.module}/manifests/karpenter/default-node-template.yaml", {
    cluster_name          = module.eks_blueprints.cluster_name
    instance_profile_name = module.karpenter.instance_profile_name
  })

  depends_on = [time_sleep.wait_30_secs_after_helm_karpenter]
}