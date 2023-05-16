module "eks-blueprints" {
  source             = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.25.0"
  cluster_name       = "toolbox"
  cluster_version    = "1.25"
  enable_irsa        = true
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  # ONLY 1 node as we will be handling autoscaling
  # with Karpenter
  managed_node_groups = {
    role = {
      capacity_type   = "ON_DEMAND"
      node_group_name = "general"
      instance_types  = ["t3a.medium"]
      desired_size    = "1"
      max_size        = "1"
      min_size        = "1"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks-blueprints.aws_eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks-blueprints.aws_eks_cluster_certificate_authority_data)
  token                  = module.eks-blueprints.aws_eks_cluster_token
}

provider "helm" {
  kubernetes {
    host                   = module.eks-blueprints.aws_eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks-blueprints.aws_eks_cluster_certificate_authority_data)
    token                  = module.eks-blueprints.aws_eks_cluster_token
  }
}