data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "external_secrets_policy_document" {
  statement {
    sid    = "AllowAccessToSecret"
    effect = "Allow"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]

    resources = [for v in var.allowed_secrets_prefix : "arn:aws:secretsmanager:${local.region}:${local.account_id}:secret:${v}"]
  }
}