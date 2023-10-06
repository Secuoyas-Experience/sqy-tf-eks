data "aws_partition" "current" {}
data "aws_region" "current" {}

# data "aws_iam_policy_document" "aws_lb" {
#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]
#     actions   = ["iam:CreateServiceLinkedRole"]

#     condition {
#       test     = "StringEquals"
#       variable = "iam:AWSServiceName"
#       values   = ["elasticloadbalancing.amazonaws.com"]
#     }
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "ec2:DescribeAccountAttributes",
#       "ec2:DescribeAddresses",
#       "ec2:DescribeAvailabilityZones",
#       "ec2:DescribeInternetGateways",
#       "ec2:DescribeVpcs",
#       "ec2:DescribeVpcPeeringConnections",
#       "ec2:DescribeSubnets",
#       "ec2:DescribeSecurityGroups",
#       "ec2:DescribeInstances",
#       "ec2:DescribeNetworkInterfaces",
#       "ec2:DescribeTags",
#       "ec2:GetCoipPoolUsage",
#       "ec2:DescribeCoipPools",
#       "elasticloadbalancing:DescribeLoadBalancers",
#       "elasticloadbalancing:DescribeLoadBalancerAttributes",
#       "elasticloadbalancing:DescribeListeners",
#       "elasticloadbalancing:DescribeListenerCertificates",
#       "elasticloadbalancing:DescribeSSLPolicies",
#       "elasticloadbalancing:DescribeRules",
#       "elasticloadbalancing:DescribeTargetGroups",
#       "elasticloadbalancing:DescribeTargetGroupAttributes",
#       "elasticloadbalancing:DescribeTargetHealth",
#       "elasticloadbalancing:DescribeTags"
#     ]
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "cognito-idp:DescribeUserPoolClient",
#       "acm:ListCertificates",
#       "acm:DescribeCertificate",
#       "iam:ListServerCertificates",
#       "iam:GetServerCertificate",
#       "waf-regional:GetWebACL",
#       "waf-regional:GetWebACLForResource",
#       "waf-regional:AssociateWebACL",
#       "waf-regional:DisassociateWebACL",
#       "wafv2:GetWebACL",
#       "wafv2:GetWebACLForResource",
#       "wafv2:AssociateWebACL",
#       "wafv2:DisassociateWebACL",
#       "shield:GetSubscriptionState",
#       "shield:DescribeProtection",
#       "shield:CreateProtection",
#       "shield:DeleteProtection"
#     ]
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "ec2:AuthorizeSecurityGroupIngress",
#       "ec2:RevokeSecurityGroupIngress"
#     ]
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]
#     actions   = ["ec2:CreateSecurityGroup"]
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["arn:${data.aws_partition.current.partition}:ec2:*:*:security-group/*"]
#     actions   = ["ec2:CreateTags"]

#     condition {
#       test     = "Null"
#       variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
#       values   = ["false"]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "ec2:CreateAction"
#       values   = ["CreateSecurityGroup"]
#     }
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["arn:${data.aws_partition.current.partition}:ec2:*:*:security-group/*"]

#     actions = [
#       "ec2:CreateTags",
#       "ec2:DeleteTags"
#     ]

#     condition {
#       test     = "Null"
#       variable = "aws:ResourceTag/ingress.k8s.aws/cluster"
#       values   = ["false"]
#     }
#   }

#   statement {
#     sid    = ""
#     effect = "Allow"

#     resources = [
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:loadbalancer/app/*/*",
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:loadbalancer/net/*/*",
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:targetgroup/*/*"
#     ]

#     actions = [
#       "elasticloadbalancing:AddTags",
#       "elasticloadbalancing:DeleteTargetGroup",
#       "elasticloadbalancing:RemoveTags"
#     ]

#     condition {
#       test     = "Null"
#       variable = "aws:ResourceTag/ingress.k8s.aws/cluster"
#       values   = ["false"]
#     }
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["arn:${data.aws_partition.current.partition}:ec2:*:*:security-group/*"]

#     actions = [
#       "ec2:CreateTags",
#       "ec2:DeleteTags"
#     ]

#     condition {
#       test     = "Null"
#       variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
#       values   = ["false"]
#     }

#     condition {
#       test     = "Null"
#       variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
#       values   = ["true"]
#     }
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "ec2:AuthorizeSecurityGroupIngress",
#       "ec2:DeleteSecurityGroup",
#       "ec2:RevokeSecurityGroupIngress"
#     ]

#     condition {
#       test     = "Null"
#       variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
#       values   = ["false"]
#     }
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "elasticloadbalancing:AddTags",
#       "elasticloadbalancing:CreateLoadBalancer",
#       "elasticloadbalancing:CreateTargetGroup"
#     ]

#     condition {
#       test     = "Null"
#       variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
#       values   = ["false"]
#     }
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "elasticloadbalancing:AddTags",
#       "elasticloadbalancing:CreateListener",
#       "elasticloadbalancing:CreateRule",
#       "elasticloadbalancing:DeleteListener",
#       "elasticloadbalancing:DeleteRule"
#     ]
#   }

#   statement {
#     sid    = ""
#     effect = "Allow"

#     resources = [
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:loadbalancer/app/*/*",
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:loadbalancer/net/*/*",
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:targetgroup/*/*"
#     ]

#     actions = [
#       "elasticloadbalancing:AddTags",
#       "elasticloadbalancing:RemoveTags",
#     ]

#     condition {
#       test     = "Null"
#       variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
#       values   = ["true"]
#     }

#     condition {
#       test     = "Null"
#       variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
#       values   = ["false"]
#     }
#   }

#   statement {
#     sid    = ""
#     effect = "Allow"

#     resources = [
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:listener/net/*/*/*",
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:listener/app/*/*/*",
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
#       "arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
#     ]

#     actions = [
#       "elasticloadbalancing:AddTags",
#       "elasticloadbalancing:RemoveTags"
#     ]
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "elasticloadbalancing:DeleteLoadBalancer",
#       "elasticloadbalancing:DeleteTargetGroup",
#       "elasticloadbalancing:ModifyLoadBalancerAttributes",
#       "elasticloadbalancing:ModifyTargetGroup",
#       "elasticloadbalancing:ModifyTargetGroupAttributes",
#       "elasticloadbalancing:SetIpAddressType",
#       "elasticloadbalancing:SetSecurityGroups",
#       "elasticloadbalancing:SetSubnets"
#     ]

#     condition {
#       test     = "Null"
#       variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
#       values   = ["false"]
#     }
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["arn:${data.aws_partition.current.partition}:elasticloadbalancing:*:*:targetgroup/*/*"]

#     actions = [
#       "elasticloadbalancing:DeregisterTargets",
#       "elasticloadbalancing:RegisterTargets"
#     ]
#   }

#   statement {
#     sid       = ""
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "elasticloadbalancing:AddListenerCertificates",
#       "elasticloadbalancing:ModifyListener",
#       "elasticloadbalancing:ModifyRule",
#       "elasticloadbalancing:RemoveListenerCertificates",
#       "elasticloadbalancing:SetWebAcl"
#     ]
#   }
# }