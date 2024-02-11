output "id" {
  value = module.velero_backup_s3_bucket.s3_bucket_id
}

output "arn" {
  value = module.velero_backup_s3_bucket.s3_bucket_arn
}