data "aws_iam_policy_document" "can_upload_to_s3_policy_document" {
  version = "2012-10-17"

  statement {
    effect  = "Allow"
    actions = ["s3:GetObject", "s3:PutObject", "s3:CopyObject"]
    resources = [
      "${aws_s3_bucket.backstage_bucket.arn}",
      "${aws_s3_bucket.backstage_bucket.arn}/*"
    ]
  }
}

data "aws_iam_openid_connect_provider" "github_oidc_provider" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_policy" "can_upload_to_s3_policy" {
  name   = "backstage-writer-policy"
  policy = data.aws_iam_policy_document.can_upload_to_s3_policy_document.json
}

data "aws_iam_policy_document" "web_identity_can_upload_to_s3_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.oidc_arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = formatlist("repo:%s:ref:refs/heads/*", var.allowed_org_repo_list)
    }
  }
}

resource "aws_iam_role" "github_role" {
  name               = "GithubCanUploadToTechdocsS3Role"
  assume_role_policy = data.aws_iam_policy_document.web_identity_can_upload_to_s3_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_gh_can_upload_to_s3_to_role" {
  role       = aws_iam_role.github_role.id
  policy_arn = aws_iam_policy.can_upload_to_s3_policy.arn
}

