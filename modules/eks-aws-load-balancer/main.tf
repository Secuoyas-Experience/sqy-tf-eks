resource "aws_iam_policy" "aws_load_balancer_controller" {
  name        = "${var.cluster_name}-lb-irsa"
  description = "Allows lb controller to manage ALB and NLB"
  policy      = data.aws_iam_policy_document.aws_lb.json

  tags = {
    Terraform = true
    eks       = var.cluster_name
    addon     = "aws-load-balancer-controller"
  }
}

module "aws_load_balancer_controller_addon" {
  source         = "aws-ia/eks-blueprints-addon/aws"
  chart          = "aws-load-balancer-controller"
  chart_version  = var.helm_version
  repository     = "https://aws.github.io/eks-charts"
  description    = "aws-load-balancer-controller Helm Chart for ingress resources"
  namespace      = "kube-system"
  set_irsa_names = ["serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"]
  role_name      = "aws-load-balancer-controller"
  create_role    = true
  create_policy  = false

  values = [
    <<-EOT
        clusterName: ${var.cluster_name}
        region: ${data.aws_region.current.name}
    EOT
  ]

  role_policies = {
    AWSLoadBalancerControllerIAMPolicy = aws_iam_policy.aws_load_balancer_controller.arn
  }

  oidc_providers = {
    this = {
      provider_arn    = var.cluster_oidc_provider_arn
      service_account = "aws-load-balancer-controller"
    }
  }
}