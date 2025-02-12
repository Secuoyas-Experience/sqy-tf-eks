module "ebs_csi_driver_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.39.0"

  role_name_prefix      = "${module.cluster_eks.cluster_name}-ebs-csi-driver-"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.cluster_eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

module "cluster_eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.3"

  cluster_name                             = var.cluster_name
  cluster_version                          = var.cluster_kubernetes_version
  cluster_endpoint_public_access           = var.cluster_public_endpoint_enabled
  cluster_endpoint_public_access_cidrs     = var.cluster_public_endpoint_whitelist_cidrs
  cluster_endpoint_private_access          = var.cluster_private_endpoint_enabled
  cluster_security_group_additional_rules  = var.cluster_security_group_additional_rules
  node_security_group_additional_rules     = var.cluster_node_security_group_additional_rules
  vpc_id                                   = module.vpc.vpc_id
  subnet_ids                               = module.vpc.private_subnets
  enable_cluster_creator_admin_permissions = true

  # https://docs.aws.amazon.com/eks/latest/userguide/eks-networking-add-ons.html
  cluster_addons = {
    coredns = {
      addon_version = var.eks_coredns_ver
    }

    kube-proxy = {
      addon_version = var.eks_kube_proxy_ver
    }

    vpc-cni = {
      addon_version = var.eks_vpc_cni_ver
    }

    aws-ebs-csi-driver = {
      addon_version            = var.eks_ebs_csi_ver
      service_account_role_arn = module.ebs_csi_driver_irsa.iam_role_arn

      configuration_values = jsonencode({
        sidecars = {
          snapshotter = {
            forceEnable = var.cluster_enable_snapshotter
          }
        }
      })
    }
  }

  eks_managed_node_groups = {
    inception = {
      capacity_type   = "ON_DEMAND"
      node_group_name = "inception"
      instance_types  = var.inception_types
      desired_size    = "${var.inception_desired_size}"
      max_size        = "${var.inception_max_size}"
      min_size        = "${var.inception_min_size}"
      public_subnets  = module.vpc.public_subnets
      private_subnets = module.vpc.private_subnets

      labels = {
        "organization"     = var.organization
        "environment"      = var.environment
        "which/node-group" = "inception"
      }

      tags = {
        Environment  = var.organization
        Organization = var.environment
        Terraform    = true
      }
    }
  }

  # https://docs.aws.amazon.com/eks/latest/userguide/access-entries.html
  access_entries = merge({
    admins = {
      username      = "KubeAdmin"
      principal_arn = aws_iam_role.kube_admin_role.arn
      policy_associations = {
        admins = {
          policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = { type = "cluster" }
        }
      }
    }
  }, var.access_entries)

  # it's importat that only one security group
  # matches provisioner. Otherwise pods won't
  # be eligible to be scheduled
  node_security_group_tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }
}

# 1. install CRDS
data "kubectl_file_documents" "snapshotter_crds" {
  content = file("${path.module}/manifests/snapshotter.crd-v7.0.2.yaml")
}

resource "kubectl_manifest" "snapshotter_crds" {
  for_each  = var.cluster_enable_snapshotter ? data.kubectl_file_documents.snapshotter_crds.manifests : {}
  yaml_body = each.value

  depends_on = [module.cluster_eks]
}

# 2. SNAPSHOTTER - Install RBAC
data "kubectl_file_documents" "snapshotter_rbac" {
  content = file("${path.module}/manifests/snapshotter.rbac-v7.0.2.yaml")
}

resource "kubectl_manifest" "snapshotter_rbac" {
  for_each   = var.cluster_enable_snapshotter ? data.kubectl_file_documents.snapshotter_rbac.manifests : {}
  yaml_body  = each.value
  depends_on = [kubectl_manifest.snapshotter_crds]
}

# 3. SNAPSHOTTER - Install controller
data "kubectl_file_documents" "snapshotter_deployment" {
  content = file("${path.module}/manifests/snapshotter.deployment-v7.0.2.yaml")
}

resource "kubectl_manifest" "snapshotter_controller" {
  for_each   = var.cluster_enable_snapshotter ? data.kubectl_file_documents.snapshotter_deployment.manifests : {}
  yaml_body  = each.value
  depends_on = [kubectl_manifest.snapshotter_rbac]
}

# 4. SNAPSHOTTER - Install ebs csi driver (Check if it works installed before)