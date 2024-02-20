output "route53_zone_arns" {
  value = [for k, v in module.zones.route53_zone_zone_arn : v]
}