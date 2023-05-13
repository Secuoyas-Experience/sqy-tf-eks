variable "cluster_name" {
  type        = string
  description = "name of the cluster this bucket is going to be accessed from"
}

variable "name" {
  type        = string
  description = "name of the bucket"
}

variable "description" {
  type        = string
  description = "description of the bucket"
}

variable "account_id" {
  type        = string
  description = "AWS account id allowed to access this bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.name
  tags = {
    Cluster     = var.cluster_name
    Name        = var.name
    Description = var.description
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.bucket

  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block_state_public_access" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "allow_read_write_to_account_root" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.bucket.arn}"]

    principals {
      type        = "AWS"
      identifiers = [var.account_id]
    }
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:DeleteObject", "s3:PutObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.account_id]
    }
  }
}

resource "aws_s3_bucket_policy" "backstage_s3_bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.allow_read_write_to_account_root.json
}

