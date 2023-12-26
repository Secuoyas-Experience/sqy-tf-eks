module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"
  name    = var.cluster_name

  cidr            = var.cluster_cidr
  azs             = var.cluster_azs
  private_subnets = var.cluster_private_subnets
  public_subnets  = var.cluster_public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_dns_support     = true
  enable_dns_hostnames   = true

  tags = {
    Terraform    = "true"
    Organization = var.organization
    Environment  = var.environment
  }

  # karpenter needs to know which subnet to use
  # when creating a new node
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "karpenter.sh/discovery"          = var.cluster_name
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
}