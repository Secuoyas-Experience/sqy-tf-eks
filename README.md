<!-- BEGIN_TF_DOCS -->
# sqy-tf-eks

[![docs](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/techdocs.yml/badge.svg)](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/techdocs.yml)

## Intro

Este repositorio es un modulo de Terraform para crear un cluster de Kubernetes para AWS (EKS). Puedes buscar mas informacion del proyecto en:

- [En el directorio /docs](./docs/)
- [En el Backstage de Secuoyas](https://backstage.toolbox.secuoyas.com)

A continuacion se muestra la documentacion de Terraform generada automaticamente con [Terraform Docs](https://terraform-docs.io/)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.31.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.0.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster_eks"></a> [cluster\_eks](#module\_cluster\_eks) | terraform-aws-modules/eks/aws | 19.21.0 |
| <a name="module_ebs_csi_driver_irsa"></a> [ebs\_csi\_driver\_irsa](#module\_ebs\_csi\_driver\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.33.0 |
| <a name="module_eks-aws-load-balancer"></a> [eks-aws-load-balancer](#module\_eks-aws-load-balancer) | ./modules/aws-load-balancer | n/a |
| <a name="module_eks_addons"></a> [eks\_addons](#module\_eks\_addons) | aws-ia/eks-blueprints-addons/aws | 1.12.0 |
| <a name="module_karpenter"></a> [karpenter](#module\_karpenter) | ./modules/karpenter | n/a |
| <a name="module_velero_backup_s3_bucket"></a> [velero\_backup\_s3\_bucket](#module\_velero\_backup\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | 3.15.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.4.0 |
| <a name="module_zones"></a> [zones](#module\_zones) | terraform-aws-modules/route53/aws//modules/zones | ~> 2.11.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.kube_admin_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_read_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons_argo_events_version"></a> [addons\_argo\_events\_version](#input\_addons\_argo\_events\_version) | Argo Events Helm Chart version | `string` | `"2.4.1"` | no |
| <a name="input_addons_argocd_version"></a> [addons\_argocd\_version](#input\_addons\_argocd\_version) | ArgoCD Helm Chart version | `string` | `"5.46.7"` | no |
| <a name="input_addons_aws_load_balancer_version"></a> [addons\_aws\_load\_balancer\_version](#input\_addons\_aws\_load\_balancer\_version) | EKS AWS Load Balancer Helm Chart version | `string` | `"1.6.1"` | no |
| <a name="input_addons_cert_manager_version"></a> [addons\_cert\_manager\_version](#input\_addons\_cert\_manager\_version) | Cert Manager operator Helm Chart version | `string` | `"1.13.3"` | no |
| <a name="input_addons_external_secrets_version"></a> [addons\_external\_secrets\_version](#input\_addons\_external\_secrets\_version) | External Secrets Helm Chart version | `string` | `"0.9.11"` | no |
| <a name="input_addons_helm_timeout"></a> [addons\_helm\_timeout](#input\_addons\_helm\_timeout) | helm release timeout seconds (default 1800 sec -> 30 min) | `number` | `1800` | no |
| <a name="input_addons_karpenter_version"></a> [addons\_karpenter\_version](#input\_addons\_karpenter\_version) | Karpenter Helm Chart version | `string` | `"v0.31.0"` | no |
| <a name="input_addons_reloader_version"></a> [addons\_reloader\_version](#input\_addons\_reloader\_version) | Stakater Reloader Helm Chart version | `string` | `"1.0.56"` | no |
| <a name="input_addons_velero_version"></a> [addons\_velero\_version](#input\_addons\_velero\_version) | Velero Helm Chart version | `string` | `"4.0.3"` | no |
| <a name="input_cluster_azs"></a> [cluster\_azs](#input\_cluster\_azs) | VPC azs | `list(string)` | n/a | yes |
| <a name="input_cluster_cidr"></a> [cluster\_cidr](#input\_cluster\_cidr) | VPC cidr | `string` | `"10.0.0.0/16"` | no |
| <a name="input_cluster_domain"></a> [cluster\_domain](#input\_cluster\_domain) | DNS Host Zone. Normally the NS domain name where ingresses are under (e.g dev.mycompany.com) | `string` | n/a | yes |
| <a name="input_cluster_kubernetes_version"></a> [cluster\_kubernetes\_version](#input\_cluster\_kubernetes\_version) | Cluster kubernetes version | `string` | `"1.27"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | AWS EKS cluster name | `string` | n/a | yes |
| <a name="input_cluster_private_subnets"></a> [cluster\_private\_subnets](#input\_cluster\_private\_subnets) | VPC private subnets. Normally used by nodes and pods | `list(string)` | n/a | yes |
| <a name="input_cluster_public_subnets"></a> [cluster\_public\_subnets](#input\_cluster\_public\_subnets) | VPC public subnets. Normally used by the AWS load balancers to expose services | `list(string)` | n/a | yes |
| <a name="input_cluster_region"></a> [cluster\_region](#input\_cluster\_region) | AWS region where the EKS cluster is located | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Type of environment (dev,stg,prod) | `string` | n/a | yes |
| <a name="input_inception_instances_count"></a> [inception\_instances\_count](#input\_inception\_instances\_count) | number of initial cluster node group instances | `number` | `1` | no |
| <a name="input_inception_instances_types"></a> [inception\_instances\_types](#input\_inception\_instances\_types) | list of types of initial cluster node group instances | `list(string)` | <pre>[<br>  "t3a.medium"<br>]</pre> | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization the cluster is used for | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END_TF_DOCS -->