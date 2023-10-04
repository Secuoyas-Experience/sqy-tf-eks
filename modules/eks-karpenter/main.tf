module "karpenter" {
  source                 = "terraform-aws-modules/eks/aws//modules/karpenter"
  version                = "19.15.3"
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
  version          = var.helm_version

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
resource "time_sleep" "wait_60_secs_after_helm_karpenter" {
  depends_on      = [helm_release.karpenter]
  create_duration = "60s"
}

resource "kubectl_manifest" "karpenter_node_template" {
  yaml_body  = templatefile("${path.module}/default-node.yaml", {
    cluster_name          = var.cluster_name
    instance_profile_name = module.karpenter.instance_profile_name
  })
  depends_on = [time_sleep.wait_60_secs_after_helm_karpenter]
}

data "kubectl_path_documents" "karpenter_providers_path" {
  pattern = "${var.provisioners_dir}/*.yaml"
}

resource "kubectl_manifest" "karpenter_providers" {
  for_each   = toset(data.kubectl_path_documents.karpenter_providers_path.documents)
  yaml_body  = each.value
  depends_on = [kubectl_manifest.karpenter_node_template]
}