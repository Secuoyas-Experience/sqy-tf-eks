module "eks_blueprints" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "19.14.0"
  cluster_name                   = local.cluster_name
  cluster_version                = "1.24"
  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  # Node Group
  # ----------
  # Just one because we are using karpenter to scale up/down
  # the cluster nodes
  eks_managed_node_groups = {
    inception = {
      capacity_type   = "ON_DEMAND"
      node_group_name = "inception"
      instance_types  = ["t3a.medium"] # c5a.large
      desired_size    = "1"
      max_size        = "1"
      min_size        = "1"
      public_subnets  = module.vpc.public_subnets
      private_subnets = module.vpc.private_subnets
    }
  }

  # aws_auth
  # --------
  # We are handling aws_auth entries here to allow
  # pods via ServiceAccount to access AWS services
  # without having to pass credentials

  # aws_auth (create ConfigMap)
  manage_aws_auth_configmap = true

  # aws_auth (roles)
  aws_auth_roles = [
    {
      rolearn  = aws_iam_role.kube_admin_role.arn
      username = "KubeAdmin"
      groups = [
        "system:masters"
      ]
    },
    {
      rolearn  = module.karpenter.role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes"
      ]
    }
  ]

  # it's importat that only one security group
  # matches provisioner. Otherwise pods won't
  # be eligible to be scheduled
  node_security_group_tags = {
    "karpenter.sh/discovery" = local.cluster_name
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_blueprints.cluster_name
}

provider "kubernetes" {
  host                   = module.eks_blueprints.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_blueprints.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks_blueprints.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks_blueprints.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_blueprints.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks_blueprints.cluster_name]
      command     = "aws"
    }
  }
}