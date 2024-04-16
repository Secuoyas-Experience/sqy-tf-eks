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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.40.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.11.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.0.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.11.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | ~> 2.0.4 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_karpenter"></a> [karpenter](#module\_karpenter) | terraform-aws-modules/eks/aws//modules/karpenter | 20.2.1 |

## Resources

| Name | Type |
|------|------|
| [helm_release.karpenter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.karpenter_default_nodeclass](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [time_sleep.wait_after_helm_karpenter](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_timeout"></a> [addon\_timeout](#input\_addon\_timeout) | helm release timout (sec) | `number` | `60` | no |
| <a name="input_addon_version"></a> [addon\_version](#input\_addon\_version) | n/a | `string` | `"v0.34.0"` | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | n/a | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_cluster_oidc_provider_arn"></a> [cluster\_oidc\_provider\_arn](#input\_cluster\_oidc\_provider\_arn) | n/a | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END_TF_DOCS -->