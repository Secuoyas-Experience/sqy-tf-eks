module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

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