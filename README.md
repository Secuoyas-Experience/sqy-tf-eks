<!-- BEGIN_TF_DOCS -->
# sqy-tf-eks

[![docs](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/docs.yaml/badge.svg)](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/docs.yaml)
[![main](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/main.yaml/badge.svg)](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/main.yaml)
![version](https://img.shields.io/badge/version-v1.22.2-blue)

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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.67.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.11.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.0.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.67.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | ~> 2.0.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster_eks"></a> [cluster\_eks](#module\_cluster\_eks) | terraform-aws-modules/eks/aws | 20.33.1 |
| <a name="module_ebs_csi_driver_irsa"></a> [ebs\_csi\_driver\_irsa](#module\_ebs\_csi\_driver\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.39.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.kube_admin_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [kubectl_manifest.snapshotter_controller](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.snapshotter_crds](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.snapshotter_rbac](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_read_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [kubectl_file_documents.snapshotter_crds](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/data-sources/file_documents) | data source |
| [kubectl_file_documents.snapshotter_deployment](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/data-sources/file_documents) | data source |
| [kubectl_file_documents.snapshotter_rbac](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_entries"></a> [access\_entries](#input\_access\_entries) | EKS access entries (https://docs.aws.amazon.com/eks/latest/userguide/access-entries.html) | `any` | `{}` | no |
| <a name="input_cluster_azs"></a> [cluster\_azs](#input\_cluster\_azs) | VPC azs | `list(string)` | n/a | yes |
| <a name="input_cluster_cidr"></a> [cluster\_cidr](#input\_cluster\_cidr) | VPC cidr | `string` | `"10.0.0.0/16"` | no |
| <a name="input_cluster_domains"></a> [cluster\_domains](#input\_cluster\_domains) | Domain names handled by this cluster. Normally the NS domain name where ingresses are under (e.g dev.mycompany.com) | `list(string)` | `[]` | no |
| <a name="input_cluster_domains_zones_arns"></a> [cluster\_domains\_zones\_arns](#input\_cluster\_domains\_zones\_arns) | Zone arns. Should be provided by another resource. If you want this module to create them use cluster\_domains variable | `list(string)` | `[]` | no |
| <a name="input_cluster_enable_snapshotter"></a> [cluster\_enable\_snapshotter](#input\_cluster\_enable\_snapshotter) | if true enables VolumeSnapshot API | `bool` | `false` | no |
| <a name="input_cluster_kubernetes_version"></a> [cluster\_kubernetes\_version](#input\_cluster\_kubernetes\_version) | Cluster kubernetes version | `string` | `"1.31"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | AWS EKS cluster name | `string` | n/a | yes |
| <a name="input_cluster_node_security_group_additional_rules"></a> [cluster\_node\_security\_group\_additional\_rules](#input\_cluster\_node\_security\_group\_additional\_rules) | security group rules between nodes | `any` | `{}` | no |
| <a name="input_cluster_private_endpoint_enabled"></a> [cluster\_private\_endpoint\_enabled](#input\_cluster\_private\_endpoint\_enabled) | if true enables private EKS endpoint | `bool` | `true` | no |
| <a name="input_cluster_private_subnets"></a> [cluster\_private\_subnets](#input\_cluster\_private\_subnets) | VPC private subnets. Normally used by nodes and pods | `list(string)` | n/a | yes |
| <a name="input_cluster_public_endpoint_enabled"></a> [cluster\_public\_endpoint\_enabled](#input\_cluster\_public\_endpoint\_enabled) | if true enables public EKS endpoint | `bool` | `true` | no |
| <a name="input_cluster_public_endpoint_whitelist_cidrs"></a> [cluster\_public\_endpoint\_whitelist\_cidrs](#input\_cluster\_public\_endpoint\_whitelist\_cidrs) | network cidrs from which EKS endpoint is accessible. By default if enable is accessible from anywhere | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_cluster_public_subnets"></a> [cluster\_public\_subnets](#input\_cluster\_public\_subnets) | VPC public subnets. Normally used by the AWS load balancers to expose services | `list(string)` | n/a | yes |
| <a name="input_cluster_region"></a> [cluster\_region](#input\_cluster\_region) | AWS region where the EKS cluster is located | `string` | n/a | yes |
| <a name="input_cluster_security_group_additional_rules"></a> [cluster\_security\_group\_additional\_rules](#input\_cluster\_security\_group\_additional\_rules) | security group rules allowed to access EKS cluster (helpful for VPN rules) | `any` | `{}` | no |
| <a name="input_eks_coredns_ver"></a> [eks\_coredns\_ver](#input\_eks\_coredns\_ver) | CoreDNS add-on version | `string` | `"v1.11.4-eksbuild.2"` | no |
| <a name="input_eks_ebs_csi_ver"></a> [eks\_ebs\_csi\_ver](#input\_eks\_ebs\_csi\_ver) | Kube-Proxy add-on version | `string` | `"v1.39.0-eksbuild.1"` | no |
| <a name="input_eks_kube_proxy_ver"></a> [eks\_kube\_proxy\_ver](#input\_eks\_kube\_proxy\_ver) | Kube-Proxy add-on version | `string` | `"v1.31.3-eksbuild.2"` | no |
| <a name="input_eks_vpc_cni_ver"></a> [eks\_vpc\_cni\_ver](#input\_eks\_vpc\_cni\_ver) | Kube-Proxy add-on version | `string` | `"v1.19.2-eksbuild.5"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Type of environment (dev,stg,prod) | `string` | n/a | yes |
| <a name="input_inception_desired_size"></a> [inception\_desired\_size](#input\_inception\_desired\_size) | number of desired cluster node group instances | `number` | `1` | no |
| <a name="input_inception_max_size"></a> [inception\_max\_size](#input\_inception\_max\_size) | number of max cluster node group instances | `number` | `1` | no |
| <a name="input_inception_min_size"></a> [inception\_min\_size](#input\_inception\_min\_size) | number of min cluster node group instances | `number` | `1` | no |
| <a name="input_inception_storage_size"></a> [inception\_storage\_size](#input\_inception\_storage\_size) | Size for storage volume in inception node group in GB | `number` | `40` | no |
| <a name="input_inception_types"></a> [inception\_types](#input\_inception\_types) | list of types of initial cluster node group instances | `list(string)` | <pre>[<br/>  "t3a.medium"<br/>]</pre> | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization the cluster is used for | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | n/a |
| <a name="output_cluster_kubernetes_version"></a> [cluster\_kubernetes\_version](#output\_cluster\_kubernetes\_version) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | n/a |
| <a name="output_vpc_azs"></a> [vpc\_azs](#output\_vpc\_azs) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_vpc_private_subnets"></a> [vpc\_private\_subnets](#output\_vpc\_private\_subnets) | n/a |
| <a name="output_vpc_private_subnets_cidr_blocks"></a> [vpc\_private\_subnets\_cidr\_blocks](#output\_vpc\_private\_subnets\_cidr\_blocks) | n/a |
| <a name="output_vpc_public_subnets"></a> [vpc\_public\_subnets](#output\_vpc\_public\_subnets) | n/a |
| <a name="output_vpc_public_subnets_cidr_blocks"></a> [vpc\_public\_subnets\_cidr\_blocks](#output\_vpc\_public\_subnets\_cidr\_blocks) | n/a |

<!-- END_TF_DOCS -->