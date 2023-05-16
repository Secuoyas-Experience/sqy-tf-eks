module "kubernetes_addons" {
  source         = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.25.0"
  eks_cluster_id = module.eks-blueprints.eks_cluster_id

  # ADDONS
  enable_amazon_eks_aws_ebs_csi_driver = true
  enable_aws_load_balancer_controller  = true
  enable_metrics_server                = true
  enable_cert_manager                  = true
  # enable_karpenter                     = true

  # KARPENTER AUTOSCALING
  # karpenter_helm_config = {
  #   name       = "karpenter"
  #   chart      = "karpenter"
  #   repository = "oci://public.ecr.aws/karpenter"
  #   version    = "v0.27.0"
  #   namespace  = "karpenter"
  # }
}