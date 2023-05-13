variable "cluster_oidc_arn" {
  type        = string
  description = "cluster oidc arn"
}

variable "cluster_oidc_name" {
  type        = string
  description = "cluster oidc name"
}

variable "service_account_name" {
  type        = string
  description = "ServiceAccount qualified name"
}

variable "bucket_name" {
  type        = string
  description = "name of the bucket"
}

variable "role_name" {
  type        = string
  description = "IAM role name associated with the K8S ServiceAccount"
}

data "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

data "aws_iam_policy_document" "s3_write_policy_document" {
  version = "2012-10-17"
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["${data.aws_s3_bucket.bucket.arn}", ]
  }
  statement {
    effect  = "Allow"
    actions = ["s3:GetObject", "s3:PutObject", "s3:CopyObject"]
    resources = [
      "${data.aws_s3_bucket.bucket.arn}",
      "${data.aws_s3_bucket.bucket.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "assume_role_with_web_identity" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.cluster_oidc_arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${var.cluster_oidc_name}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.cluster_oidc_name}:sub"
      values   = [var.service_account_name]
    }
  }
}

resource "aws_iam_role" "service_account_can_write_to_s3" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_with_web_identity.json

  inline_policy {
    name   = "PolicyFor${var.role_name}"
    policy = data.aws_iam_policy_document.s3_write_policy_document.json
  }
}