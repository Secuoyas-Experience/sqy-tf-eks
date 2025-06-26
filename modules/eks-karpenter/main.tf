module "karpenter" {
  source                 = "terraform-aws-modules/eks/aws//modules/karpenter"
  version                = "20.33.1"
  cluster_name           = var.cluster_name
  irsa_oidc_provider_arn = var.cluster_oidc_provider_arn
  enable_irsa            = true
  enable_v1_permissions  = true

  node_iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    CloudWatchReadOnlyAccess     = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
    KarpenterCacheECRPermission = aws_iam_policy.karpenter_cache_ecr_permission.arn
  }
}

resource "aws_iam_policy" "karpenter_spot_permission" {
  name        = "KarpenterSpotPermission-${var.cluster_name}"
  description = "allow Karpenter to create spot instances"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = "iam:CreateServiceLinkedRole"
        Resource = "*"
        Condition = {
          StringLike = {
            "iam:AWSServiceName" : "spot.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = module.karpenter.iam_role_name
  policy_arn = aws_iam_policy.karpenter_spot_permission.arn
}




resource "aws_iam_policy" "karpenter_cache_ecr_permission" {
  name        = "KarpenterCacheECRPermission-${var.cluster_name}"
  description = "Allow Karpenter to ecr cache"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ecr:BatchImportUpstreamImage",
          "ecr:CreateRepository",
          "ecr:CreatePullThroughCacheRule"
        ]
        Resource = "*"
      }
    ]
  })
}