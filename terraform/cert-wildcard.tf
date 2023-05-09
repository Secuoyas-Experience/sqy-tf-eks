# module "acm" {
#   source                    = "terraform-aws-modules/acm/aws"
#   domain_name               = local.cluster_domain_name
#   zone_id                   = data.hosted_zone.zone_id
#   subject_alternative_names = "*.${local.cluster_domain_name}"
#   wait_for_validation       = true

#   tags = {
#     Terraform    = true
#     Name         = local.cluster_domain_name
#     Organization = "secuoyas"
#     Environment  = "toolbox"
#   }
# }