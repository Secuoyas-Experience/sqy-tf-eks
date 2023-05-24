module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"
  name    = local.cluster_name

  cidr            = "10.0.0.0/16"
  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_dns_support     = true
  enable_dns_hostnames   = true

  tags = {
    Terraform   = "true"
    Environment = local.cluster_name
  }

  # karpenter needs to know which subnet to use
  # when creating a new node
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "karpenter.sh/discovery"          = local.cluster_name
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
}