# SSL certs required by apps deployed in Toolbox org
# 
# Each file should represent a subdomain of 
# *.toolbox.secuoyas.com e.g:
# 
# wildcard.tf -> *.toolbox.secuoyas.com
# 
module "certificates" {
  source = "./certificates"
}

# DNS entries required by apps deployed in Toolbox org
#
# Each file should represent a subdomain of 
# *.toolbox.secuoyas.com e.g:
# 
# grafana.tf -> grafana.toolbox.secuoyas.com
# 
module "dns_entries" {
  source = "./route53"
}

# OIDC provider and roles used by Terraform Cloud for
# interventions affecting Toolbox organization. 
#
# Each file should represent a role of a given TC project
# or workspace, e.g:
#
# p-toolbox.tf -> tc-p-toolbox-role
#
# The example will create a role named tc-project-toolbox-role
# and it is supposed to be used by all workspaces under toolbox
# project
#
# p-toolbox-w-toolbox-k8s -> tc-p-toolbox-w-toolbox-k8s-role
#
# This role only will be used by a workspace called toolbox-k8s
# under the toolbox project
module "oidc_terraform_cloud" {
  source = "./oidc-tc"
}

# S3 buckets created in Toolbox organization
#
# The file should be named after the name of the bucket, e.g:
#
# my-bucket.tf -> my-bucket
#
module "s3_buckets" {
    source = "./s3"
}