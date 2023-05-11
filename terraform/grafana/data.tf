data "aws_route53_zone" "cluster_hosted_zone" {
  name = var.domain
}

data "aws_caller_identity" "current" {}