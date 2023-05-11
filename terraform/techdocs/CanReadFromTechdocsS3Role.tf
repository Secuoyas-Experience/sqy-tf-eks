data "aws_iam_policy_document" "backstage_read_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.backstage_bucket.arn}", ]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.backstage_bucket.arn}/*"]
  }
}

data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "backstage_read_policy" {
  name   = "${local.bucket_name}-reader-policy"
  policy = data.aws_iam_policy_document.backstage_read_policy_document.json
}

resource "aws_iam_role" "can_read_from_techdocs_s3_role" {
  name               = "CanReadFromTechdocsS3Role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "can_read_from_techdocs_s3_role_attachment" {
  role       = aws_iam_role.can_read_from_techdocs_s3_role.id
  policy_arn = aws_iam_policy.backstage_read_policy.arn
}