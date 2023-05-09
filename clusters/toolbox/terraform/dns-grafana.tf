data "aws_alb" "grafana_alb" {
  name = "grafana-alb"
}

resource "aws_route53_record" "amqp_pub_dns_entry" {
  zone_id = data.aws_route53_zone.cluster_hosted_zone.zone_id
  name    = "grafana"
  type    = "A"

  alias {
    name                   = data.aws_alb.grafana_alb.dns_name
    zone_id                = data.aws_alb.grafana_alb.zone_id
    evaluate_target_health = true
  }
}
