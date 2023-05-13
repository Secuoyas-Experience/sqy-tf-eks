module "s3_docs" {
  source                  = "./s3"
  allowed_org_repo_list   = var.allowed_org_repo_list
  oidc_arn                = var.oidc_arn
  backstage_doppler_token = var.backstage_doppler_token
}



