provider "kubectl" {
  host                   = module.eks_blueprints.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_blueprints.cluster_certificate_authority_data)
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

data "kubectl_path_documents" "provisioner_yamls" {
  pattern = "${path.module}/manifests/karpenter/provisioners/*.yaml"
}

# karpenter default provisioner
resource "kubectl_manifest" "karpenter_provisioner" {
  for_each   = toset(data.kubectl_path_documents.provisioner_yamls.documents)
  yaml_body  = each.value
  depends_on = [time_sleep.wait_30_secs_after_helm_karpenter]
}

# karpenter default new node instance template
resource "kubectl_manifest" "karpenter_template" {
  yaml_body = templatefile("${path.module}/manifests/karpenter/nodes/default.yaml", {
    cluster_name          = module.eks_blueprints.cluster_name
    instance_profile_name = module.karpenter.instance_profile_name
  })

  depends_on = [time_sleep.wait_30_secs_after_helm_karpenter]
}