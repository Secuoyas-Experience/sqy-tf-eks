module "velero_backup_s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "3.15.1"
  bucket        = var.name
  acl           = "private"
  create_bucket = var.create

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "aws:kms"
      }
    }
  }
}