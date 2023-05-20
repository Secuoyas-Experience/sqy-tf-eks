module "kubernetes_addons" {
  source         = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.31.0"
  eks_cluster_id = module.eks_blueprints.cluster_name

  # ADDONS
  enable_amazon_eks_aws_ebs_csi_driver = true # volume auto provisioning
  enable_aws_load_balancer_controller  = true # load balancer auto provisioning
  enable_metrics_server                = true # getting cluster metrics
  enable_cert_manager                  = true # certs auto provisioning (ACME)
  enable_karpenter                     = true # node autoscaling
  enable_kube_prometheus_stack         = true # monitoring (prometheus/grafana)
  # enable_velero                        = true # backup tool

  # VELERO BACKUP
  # velero_helm_config = {
  #   backup_s3_bucket = module.velero_s3_bucket.s3_bucket_id
  # }


  # depends_on = [ module.velero_s3_bucket ]
}