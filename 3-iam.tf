data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "eks_read_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "eks:ListAddons",
      "eks:ListUpdates",
      "eks:ListClusters",
      "eks:ListFargateProfiles",
      "eks:ListIdentityProviderConfigs",
      "eks:ListNodegroups",
      "eks:ListTagsForResource",
      "eks:AccessKubernetesApi",
      "eks:DescribeAddon",
      "eks:DescribeAddonConfiguration",
      "eks:DescribeAddonVersions",
      "eks:DescribeCluster",
      "eks:DescribeFargateProfile",
      "eks:DescribeIdentityProviderConfig",
      "eks:DescribeNodegroup",
      "eks:DescribeUpdate"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "kube_admin_role" {
  name               = "${local.cluster_name}-kube-admin"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json

  inline_policy {
    name   = "${local.cluster_name}-kube-allowed-to-read"
    policy = data.aws_iam_policy_document.eks_read_policy_document.json
  }
}