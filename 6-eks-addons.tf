module "velero_s3_bucket" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  bucket                   = "${local.cluster_name}-velero"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
}

module "kubernetes_addons" {
  source         = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.31.0"
  eks_cluster_id = module.eks_blueprints.cluster_name

  # ADDONS
  enable_amazon_eks_vpc_cni            = true # integrates with AWS VPC
  enable_amazon_eks_aws_ebs_csi_driver = true # volume auto provisioning
  enable_aws_load_balancer_controller  = true # load balancer auto provisioning
  enable_metrics_server                = true # getting cluster metrics
  enable_external_dns                  = true # updates DNS entries
  enable_cert_manager                  = true # certs auto provisioning (ACME)   
  enable_kube_prometheus_stack         = true # monitoring (prometheus/grafana)
  enable_velero                        = true # backup tool

  # ADDONS CUSTOMIZATION (aws-lb)
  eks_cluster_domain = "toolbox.secuoyas.com"

  # ADDONS CUSTOMIZATION (cert-manager)
  cert_manager_domain_names      = ["toolbox.secuoyas.com"]
  cert_manager_letsencrypt_email = "hola@secuoyas.com"

  # ADDONS CUSTOMIZATION (velero)
  velero_helm_config = {
    backup_s3_bucket = module.velero_s3_bucket.s3_bucket_id                 # required by IAM policy
    values = [templatefile("${path.module}/manifests/velero/values.yaml", { # required for helm values.yaml
      bucket = module.velero_s3_bucket.s3_bucket_id
      region = "eu-central-1"
    })]
  }

  depends_on = [
    module.velero_s3_bucket,
    kubectl_manifest.karpenter_template,
    kubectl_manifest.karpenter_provisioner
  ]
}