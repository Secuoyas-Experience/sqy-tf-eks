module "velero_s3_bucket" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "3.15.1"
  bucket                   = "${var.cluster_name}-velero"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
}

module "kubernetes_addons" {
  source         = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.32.1"
  eks_cluster_id = module.cluster_eks.cluster_name

  # ADDONS
  enable_amazon_eks_vpc_cni            = true # integrates with AWS VPC
  enable_amazon_eks_aws_ebs_csi_driver = true # volume auto provisioning
  enable_aws_load_balancer_controller  = true # load balancer auto provisioning
  enable_external_dns                  = true # updates DNS entries
  enable_metrics_server                = true # getting cluster metrics
  enable_velero                        = true # backup tool

  # EXTERNAL DNS
  eks_cluster_domain = var.cluster_domain

  external_dns_helm_config = {
    set_values = [{
      name  = "policy"
      value = "sync"
    }]
  }

  # VELERO
  velero_backup_s3_bucket = module.velero_s3_bucket.s3_bucket_id # redundant but required because of bug

  velero_helm_config = {
    version          = var.addons_velero_version
    backup_s3_bucket = module.velero_s3_bucket.s3_bucket_id                 # required by IAM policy
    values = [templatefile("${path.module}/manifests/velero/values.yaml", { # required for helm values.yaml
      bucket = module.velero_s3_bucket.s3_bucket_id
      region = var.cluster_region
    })]
  }

  depends_on = [
    module.velero_s3_bucket,
    module.cluster_eks
  ]
}
