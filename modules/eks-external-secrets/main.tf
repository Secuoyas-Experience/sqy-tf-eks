resource "helm_release" "external-secrets" {
  namespace        = "external-secrets"
  create_namespace = true
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  version          = var.helm_version
}

resource "aws_iam_policy" "external_secrets_iam_policy" {
  count       = var.use_ssm ? 1 : 0
  name        = "external-secrets"
  description = "Allows to access AWS secret manager of certain secret paths"
  policy      = data.aws_iam_policy_document.external_secrets_policy_document.json

  tags = {
    Terraform = true
    eks       = var.cluster_name
    addon     = "external-secrets"
  }
}