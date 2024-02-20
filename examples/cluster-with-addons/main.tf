module "zones" {
  source  = "../../modules/aws-dns-zones"
  domains = ["my.domain.es"]
}

module "cluster" {
  source                     = "../.."
  cluster_name               = "my-domain-es"
  cluster_kubernetes_version = "1.29"
  cluster_cidr               = "10.0.0.0/16"
  cluster_region             = "eu-central-1"
  cluster_azs                = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  cluster_private_subnets    = ["10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/24"]
  cluster_public_subnets     = ["10.0.192.0/24", "10.0.193.0/24", "10.0.194.0/24"]
  inception_min_size         = 1
  inception_max_size         = 2
  inception_desired_size     = 2
  environment                = "dev"
  organization               = "my.domain.es"
}

module "velero_backup_s3" {
  source = "../../modules/aws-s3"
  name   = "my-domain-es-backup"
}

module "addons" {
  source                     = "../../modules/eks-addons"
  cluster_name               = module.cluster.cluster_name
  cluster_version            = module.cluster.cluster_kubernetes_version
  cluster_endpoint           = module.cluster.cluster_endpoint
  cluster_domains_zones_arns = module.zones.route53_zone_arns
  cluster_oidc_provider_arn  = module.cluster.oidc_provider_arn
  addons_velero_bucket_arn   = module.velero_backup_s3.arn
}

module "storage_classes" {
  depends_on = [module.addons]
  source     = "../../modules/eks-apply-manifests-in-dir"
  manifests  = []
}

module "karpenter_nodepools" {
  depends_on = [module.addons]
  source     = "../../modules/eks-apply-manifests-in-dir"

  manifests = [
    "${path.module}/karpenter/example-nodepool.yaml"
  ]
}