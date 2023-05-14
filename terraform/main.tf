# locals {
#   domain = "toolbox.secuoyas.com"
# }

# # Common infrastructure files 
# module "common" {
#   source = "./common"
#   domain = local.domain
# }

# # Grafana infrastructure files
# module "grafana" {
#   source = "./grafana"
#   domain = local.domain
# }

# # Backstage infrastructure files
# module "backstage" {
#   source                  = "./backstage"
#   domain                  = local.domain
#   oidc_arn                = module.common.github_cloud_oidc_arn
#   backstage_doppler_token = var.backstage_doppler_token

#   # list of org/repo pairs allowed to upload files to S3
#   allowed_org_repo_list = [
#     "Secuoyas-Experience/toolbox-k8s"
#   ]
# }

# module "loki" {
#   source       = "./loki"
#   cluster_name = "toolbox"
# }