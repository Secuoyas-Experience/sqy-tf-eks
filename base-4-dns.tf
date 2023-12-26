data "aws_route53_zone" "hosted_zone" {
  name = var.cluster_domain
}

module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"
  create  = data.aws_route53_zone.hosted_zone != null

  zones = {
    "${var.cluster_domain}" = {
      comment = var.cluster_domain
      tags = {
        Terraform = true
        Name      = var.cluster_domain
      }
    }
  }

  tags = {
    Terraform = true
  }
}