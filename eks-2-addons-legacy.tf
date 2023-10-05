module "kubernetes_addons" {
  source         = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.32.1"
  eks_cluster_id = module.cluster_eks.cluster_name

  # ADDONS
  enable_amazon_eks_vpc_cni            = true # integrates with AWS VPC
  enable_amazon_eks_aws_ebs_csi_driver = true # volume auto provisioning
  enable_external_dns                  = true # updates DNS entries
  enable_metrics_server                = true # getting cluster metrics

  # EXTERNAL DNS
  eks_cluster_domain = var.cluster_domain

  external_dns_helm_config = {
    set_values = [{
      name  = "policy"
      value = "sync"
    }]
  }

  depends_on = [
    module.cluster_eks
  ]
}
