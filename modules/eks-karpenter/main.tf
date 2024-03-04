module "karpenter" {
  source                 = "terraform-aws-modules/eks/aws//modules/karpenter"
  version                = "20.2.1"
  cluster_name           = var.cluster_name
  irsa_oidc_provider_arn = var.cluster_oidc_provider_arn
  enable_irsa            = true

  node_iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true
  name             = "karpenter"
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter"
  timeout          = var.addon_timeout
  version          = var.addon_version
  wait             = false
  wait_for_jobs    = false

  set {
    name  = "settings.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "replicas"
    value = "2"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.karpenter.iam_role_arn
  }

  set {
    name  = "settings.aws.clusterEndpoint"
    value = var.cluster_endpoint
  }

  set {
    name  = "settings.aws.interruptionQueueName"
    value = module.karpenter.queue_name
  }

  depends_on = [module.karpenter]
}

###################################
## KARPENTER BOOTSTRAP MANIFESTS ##
###################################

# webhook doesn't pickup and I can't set the liveProbeness
# to last longer so that's why I'm creating a terraform
# timeout
resource "time_sleep" "wait_after_helm_karpenter" {
  depends_on      = [helm_release.karpenter]
  create_duration = "120s"
}

resource "kubectl_manifest" "karpenter_default_nodeclass" {
  depends_on        = [time_sleep.wait_after_helm_karpenter]
  server_side_apply = true
  yaml_body = templatefile("${path.module}/manifests/nodeclass/default.yaml", {
    cluster_name = var.cluster_name
    role_name    = module.karpenter.node_iam_role_name
  })
}