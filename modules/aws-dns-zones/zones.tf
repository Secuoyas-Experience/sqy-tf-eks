module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 4.1.0"

  zones = { for v in var.domains : v =>
    {
      comment = v
      tags = {
        Terraform = true
        Name      = v
      }

    }
  }

  tags = {
    Terraform = true
  }
}