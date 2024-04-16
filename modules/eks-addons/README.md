<!-- BEGIN_TF_DOCS -->
# sqy-tf-eks

[![docs](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/docs.yaml/badge.svg)](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/docs.yaml)
[![main](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/main.yaml/badge.svg)](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/main.yaml)
![version](https://img.shields.io/badge/version-v1.12.2-blue)

## Intro

Este repositorio es un modulo de Terraform para crear un cluster de Kubernetes para AWS (EKS). Puedes buscar mas informacion del proyecto [en el directorio /docs](./docs/).

## Ejemplo

```ruby
module "cluster" {
  source                     = "git@github.com:Secuoyas-Experience/sqy-tf-eks.git?ref=1.8.0"
  cluster_name               = "my-domain-es"
  cluster_kubernetes_version = "1.29"
  cluster_cidr               = "10.0.0.0/16"
  cluster_region             = "eu-central-1"
  cluster_azs                = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  cluster_private_subnets    = ["10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/24"]
  cluster_public_subnets     = ["10.0.192.0/24", "10.0.193.0/24", "10.0.194.0/24"]
  inception_min_size         = 1
  inception_max_size         = 1
  inception_desired_size     = 1
  environment                = "dev"
  organization               = "my.domain.es"
}
```

A continuacion se muestra la documentacion de Terraform generada con [Terraform Docs](https://terraform-docs.io/)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.40.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.0.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_addons_extra"></a> [eks\_addons\_extra](#module\_eks\_addons\_extra) | aws-ia/eks-blueprints-addons/aws | 1.15.1 |
| <a name="module_karpenter"></a> [karpenter](#module\_karpenter) | ../eks-karpenter | n/a |
| <a name="module_velero"></a> [velero](#module\_velero) | ../eks-velero | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons_argo_events_enabled"></a> [addons\_argo\_events\_enabled](#input\_addons\_argo\_events\_enabled) | if true argo-events is enabled | `bool` | `false` | no |
| <a name="input_addons_argo_events_version"></a> [addons\_argo\_events\_version](#input\_addons\_argo\_events\_version) | Argo Events Helm Chart version | `string` | `"2.4.1"` | no |
| <a name="input_addons_argocd_enabled"></a> [addons\_argocd\_enabled](#input\_addons\_argocd\_enabled) | if true ArgoCD is enabled | `bool` | `false` | no |
| <a name="input_addons_argocd_version"></a> [addons\_argocd\_version](#input\_addons\_argocd\_version) | ArgoCD Helm Chart version | `string` | `"5.46.7"` | no |
| <a name="input_addons_aws_efs_csi_driver_enabled"></a> [addons\_aws\_efs\_csi\_driver\_enabled](#input\_addons\_aws\_efs\_csi\_driver\_enabled) | if true aws-efs-csi-driver is enabled | `bool` | `false` | no |
| <a name="input_addons_aws_load_balancer_version"></a> [addons\_aws\_load\_balancer\_version](#input\_addons\_aws\_load\_balancer\_version) | EKS AWS Load Balancer Helm Chart version | `string` | `"1.6.2"` | no |
| <a name="input_addons_cert_manager_enabled"></a> [addons\_cert\_manager\_enabled](#input\_addons\_cert\_manager\_enabled) | if true cert-manager is enabled | `bool` | `true` | no |
| <a name="input_addons_cert_manager_version"></a> [addons\_cert\_manager\_version](#input\_addons\_cert\_manager\_version) | Cert Manager operator Helm Chart version | `string` | `"1.13.3"` | no |
| <a name="input_addons_external_dns_version"></a> [addons\_external\_dns\_version](#input\_addons\_external\_dns\_version) | n/a | `string` | `"1.14.3"` | no |
| <a name="input_addons_external_secrets_version"></a> [addons\_external\_secrets\_version](#input\_addons\_external\_secrets\_version) | n/a | `string` | `"0.9.11"` | no |
| <a name="input_addons_helm_repository_password"></a> [addons\_helm\_repository\_password](#input\_addons\_helm\_repository\_password) | credentials (password) for helm repositories hosted in github.com | `string` | `null` | no |
| <a name="input_addons_helm_repository_username"></a> [addons\_helm\_repository\_username](#input\_addons\_helm\_repository\_username) | credentials (username) for helm repositories hosted in github.com | `string` | `null` | no |
| <a name="input_addons_helm_timeout"></a> [addons\_helm\_timeout](#input\_addons\_helm\_timeout) | helm release timeout seconds (default 1800 sec -> 30 min) | `number` | `1800` | no |
| <a name="input_addons_karpenter_nodepools_path"></a> [addons\_karpenter\_nodepools\_path](#input\_addons\_karpenter\_nodepools\_path) | Karpenter's provisioners path | `string` | `""` | no |
| <a name="input_addons_karpenter_version"></a> [addons\_karpenter\_version](#input\_addons\_karpenter\_version) | Karpenter Helm Chart version | `string` | `"v0.34.0"` | no |
| <a name="input_addons_metrics_server_version"></a> [addons\_metrics\_server\_version](#input\_addons\_metrics\_server\_version) | n/a | `string` | `"3.12.0"` | no |
| <a name="input_addons_reloader_version"></a> [addons\_reloader\_version](#input\_addons\_reloader\_version) | Stakater Reloader Helm Chart version | `string` | `"1.0.56"` | no |
| <a name="input_addons_velero_bucket_arn"></a> [addons\_velero\_bucket\_arn](#input\_addons\_velero\_bucket\_arn) | if addons\_velero\_create\_bucket is false then we need to provide the bucket arn | `string` | n/a | yes |
| <a name="input_addons_velero_enabled"></a> [addons\_velero\_enabled](#input\_addons\_velero\_enabled) | Enable velero (enabled by default) | `bool` | `false` | no |
| <a name="input_addons_velero_version"></a> [addons\_velero\_version](#input\_addons\_velero\_version) | Velervar.cluster\_nameo Helm Chart version | `string` | `"4.0.3"` | no |
| <a name="input_cluster_domains_zones_arns"></a> [cluster\_domains\_zones\_arns](#input\_cluster\_domains\_zones\_arns) | Zone arns. Should be provided by another resource. If you want this module to create them use cluster\_domains variable | `list(string)` | `[]` | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | n/a | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | AWS EKS cluster name | `string` | n/a | yes |
| <a name="input_cluster_oidc_provider_arn"></a> [cluster\_oidc\_provider\_arn](#input\_cluster\_oidc\_provider\_arn) | n/a | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_karpenter"></a> [karpenter](#output\_karpenter) | n/a |

<!-- END_TF_DOCS -->