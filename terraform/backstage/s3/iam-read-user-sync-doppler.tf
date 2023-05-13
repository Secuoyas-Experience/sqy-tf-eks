resource "doppler_secret" "backstage_read_aws_secret_key_id" {
  project = "toolbox-backstage"
  config  = "gh"
  name    = "AWS_ACCESS_KEY_ID"
  value   = module.backstage_reader_iam_user.iam_access_key_id
}

resource "doppler_secret" "backstage_read_aws_secret_access_key" {
  project = "toolbox-backstage"
  config  = "gh"
  name    = "AWS_SECRET_ACCESS_KEY"
  value   = module.backstage_reader_iam_user.iam_access_key_id
}

resource "doppler_secret" "backstage_read_aws_s3_bucket" {
  project = "toolbox-backstage"
  config  = "gh"
  name    = "AWS_S3_BUCKET"
  value   = aws_s3_bucket.backstage_bucket.id
}

resource "doppler_secret" "backstage_read_aws_default_region" {
  project = "toolbox-backstage"
  config  = "gh"
  name    = "AWS_DEFAULT_REGION"
  value   = aws_s3_bucket.backstage_bucket.region
}