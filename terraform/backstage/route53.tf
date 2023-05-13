data "aws_route53_zone" "cluster_hosted_zone" {
  name = var.domain
}

data "aws_alb" "toolbox_alb" {
  name = "grafana-alb"
}

resource "aws_route53_record" "alexandria" {
  zone_id = data.aws_route53_zone.cluster_hosted_zone.zone_id
  name    = "alexandria"
  type    = "A"

  alias {
    name                   = data.aws_alb.grafana_alb.dns_name
    zone_id                = data.aws_alb.grafana_alb.zone_id
    evaluate_target_health = true
  }
}
