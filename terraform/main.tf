locals {
  domain = "toolbox.secuoyas.com"
}

# SSL certs required by apps deployed in Toolbox org
module "certificates" {
  source = "./certificates"
  domain = local.domain
}

# Grafana infrastructure files 
module "oidc-providers" {
  source = "./oidc-providers"
}

# Grafana infrastructure files
module "grafana" {
  source = "./grafana"
  domain = local.domain
}

# Terraform cloud infrastructure file
module "terraform_cloud" {
  source   = "./terraform-cloud"
  oidc_arn = module.oidc-providers.terraform_cloud_oidc_arn
}

#
# Backstage techdocs infrastructure files
#
# allowed_org_repo_list is a list of org/repo strings
# allowed to push techdocs documentation to the
# techdocs S3 that will be available through
# Spotify's Backstage instance
module "techdocs" {
  source                = "./techdocs"
  allowed_org_repo_list = ["Secuoyas-Experience/toolbox-k8s"]
  oidc_arn              = module.oidc-providers.github_cloud_oidc_arn
}