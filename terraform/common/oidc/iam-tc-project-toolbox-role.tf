data "aws_iam_policy_document" "web_identity_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.terraform_cloud_oidc_provider.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      # values   = ["aws.workload.identity"]
      values   = ["*"]
    }

    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      # values   = ["organization:secuoyas:project:Toolbox:*"]
      values   = ["*"]
    }
  }
}

data "aws_iam_policy" "AdministratorAccess" {
  name = "AdministratorAccess"
}

resource "aws_iam_role" "github_role" {
  name                = "tc-p-toolbox-role"
  assume_role_policy  = data.aws_iam_policy_document.web_identity_role_policy.json
  managed_policy_arns = [data.aws_iam_policy.AdministratorAccess.arn]
}