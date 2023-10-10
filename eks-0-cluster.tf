module "cluster_eks" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "19.16.0"
  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_kubernetes_version
  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  # Node Group
  # ----------
  # Just one because we are using karpenter to scale up/down
  # the cluster nodes
  eks_managed_node_group_defaults = {
    iam_role_additional_policies = {
      AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    }
  }

  eks_managed_node_groups = {
    inception = {
      capacity_type   = "ON_DEMAND"
      node_group_name = "inception"
      instance_types  = ["t3.medium"]
      desired_size    = "2"
      max_size        = "2"
      min_size        = "2"
      public_subnets  = module.vpc.public_subnets
      private_subnets = module.vpc.private_subnets

      labels = {
        "organization"      = var.organization
        "environment"       = var.environment
        "sqy.es/node-group" = "inception"
      }

      tags = {
        Environment  = var.organization
        Organization = var.environment
        Terraform    = true
      }
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
    "karpenter.sh/discovery" = var.cluster_name
  }
}

provider "kubernetes" {
  host                   = module.cluster_eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.cluster_eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.cluster_eks.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.cluster_eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.cluster_eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.cluster_eks.cluster_name, ]
    }
  }
}

provider "kubectl" {
  host                   = module.cluster_eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.cluster_eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.cluster_eks.cluster_name]
  }
}
