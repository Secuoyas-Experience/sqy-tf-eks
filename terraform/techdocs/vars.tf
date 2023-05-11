variable "allowed_org_repo_list" {
  type        = list(string)
  description = "list of org/repo pairs allowed to upload files to S3"
}