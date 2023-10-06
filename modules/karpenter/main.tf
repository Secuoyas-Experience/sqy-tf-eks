module "karpenter" {
  source                 = "terraform-aws-modules/eks/aws//modules/karpenter"
  version                = "19.16.0"
  cluster_name           = var.cluster_name
  irsa_oidc_provider_arn = var.cluster_oidc_provider_arn
  create_irsa            = true
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true
  name             = "karpenter"
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter"
  timeout          = var.timeout
  version          = var.helm_version
  wait_for_jobs    = true

  set {
    name  = "settings.aws.clusterName"
    value = var.cluster_name
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
    value = var.cluster_endpoint
  }

  set {
    name  = "settings.aws.defaultInstanceProfile"
    value = module.karpenter.instance_profile_name
  }

  set {
    name  = "settings.aws.interruptionQueueName"
    value = module.karpenter.queue_name
  }

  set {
    name  = "nodeSelector.sqy\\.es/node-group"
    value = var.node_group_name
  }

  depends_on = [module.karpenter]
}

# webhook doesn't pickup and I can't set the liveProbeness
# to last longer so that's why I'm creating a terraform
# timeout
resource "time_sleep" "wait_after_helm_karpenter" {
  depends_on      = [helm_release.karpenter]
  create_duration = "120s"
}

resource "kubectl_manifest" "karpenter_default_node_template" {
  yaml_body = templatefile("${path.module}/default-node.yaml", {
    cluster_name          = var.cluster_name
    instance_profile_name = module.karpenter.instance_profile_name
  })
  depends_on = [time_sleep.wait_after_helm_karpenter]
}

resource "kubectl_manifest" "karpenter_default_provider" {
  yaml_body  = file("${path.module}/default-provisioner.yaml")
  depends_on = [kubectl_manifest.karpenter_default_node_template]
}