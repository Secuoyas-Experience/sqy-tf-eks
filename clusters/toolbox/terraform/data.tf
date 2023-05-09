data "aws_route53_zone" "cluster_hosted_zone" {
  name = local.cluster_domain_name
}