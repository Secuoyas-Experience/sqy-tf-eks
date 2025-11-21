<!-- BEGIN_TF_DOCS -->
# sqy-tf-eks

[![docs](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/docs.yaml/badge.svg)](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/docs.yaml)
[![main](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/main.yaml/badge.svg)](https://github.com/Secuoyas-Experience/sqy-tf-eks/actions/workflows/main.yaml)
![version](https://img.shields.io/badge/version-v1.22.32-blue)

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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.89.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.17.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.1.3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.17.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_addons_extra"></a> [eks\_addons\_extra](#module\_eks\_addons\_extra) | aws-ia/eks-blueprints-addons/aws | 1.20.0 |
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
| <a name="input_addons_argocd_az"></a> [addons\_argocd\_az](#input\_addons\_argocd\_az) | ArgoCD AZ where nodes should run | `string` | n/a | yes |
| <a name="input_addons_argocd_dex_image_repository"></a> [addons\_argocd\_dex\_image\_repository](#input\_addons\_argocd\_dex\_image\_repository) | ArgoCD dex image repository | `string` | `"ghcr.io/dexidp/dex"` | no |
| <a name="input_addons_argocd_dex_image_repository_tag"></a> [addons\_argocd\_dex\_image\_repository\_tag](#input\_addons\_argocd\_dex\_image\_repository\_tag) | ArgoCD dex image tag | `string` | `"v2.37.0"` | no |
| <a name="input_addons_argocd_enabled"></a> [addons\_argocd\_enabled](#input\_addons\_argocd\_enabled) | if true ArgoCD is enabled | `bool` | `false` | no |
| <a name="input_addons_argocd_image_repository"></a> [addons\_argocd\_image\_repository](#input\_addons\_argocd\_image\_repository) | ArgoCD image repository | `string` | `"quay.io/argoproj/argocd"` | no |
| <a name="input_addons_argocd_image_repository_tag"></a> [addons\_argocd\_image\_repository\_tag](#input\_addons\_argocd\_image\_repository\_tag) | ArgoCD image tag | `string` | `"v2.8.7"` | no |
| <a name="input_addons_argocd_redis_image_repository"></a> [addons\_argocd\_redis\_image\_repository](#input\_addons\_argocd\_redis\_image\_repository) | ArgoCD redis image repository | `string` | `"public.ecr.aws/docker/library/redis"` | no |
| <a name="input_addons_argocd_redis_image_repository_tag"></a> [addons\_argocd\_redis\_image\_repository\_tag](#input\_addons\_argocd\_redis\_image\_repository\_tag) | ArgoCD redis image tag | `string` | `"7.0.13-alpine"` | no |
| <a name="input_addons_argocd_server_ingress_enabled"></a> [addons\_argocd\_server\_ingress\_enabled](#input\_addons\_argocd\_server\_ingress\_enabled) | if true ArgoCD server ingress is enabled | `bool` | `true` | no |
| <a name="input_addons_argocd_server_ingress_host"></a> [addons\_argocd\_server\_ingress\_host](#input\_addons\_argocd\_server\_ingress\_host) | ArgoCD server ingress host | `string` | n/a | yes |
| <a name="input_addons_argocd_version"></a> [addons\_argocd\_version](#input\_addons\_argocd\_version) | ArgoCD Helm Chart version | `string` | `"5.46.7"` | no |
| <a name="input_addons_aws_efs_csi_driver_enabled"></a> [addons\_aws\_efs\_csi\_driver\_enabled](#input\_addons\_aws\_efs\_csi\_driver\_enabled) | if true aws-efs-csi-driver is enabled | `bool` | `false` | no |
| <a name="input_addons_aws_efs_csi_driver_image_repository"></a> [addons\_aws\_efs\_csi\_driver\_image\_repository](#input\_addons\_aws\_efs\_csi\_driver\_image\_repository) | EFS CSI Driver image repository | `map(string)` | <pre>{<br/>  "controller": "public.ecr.aws/efs-csi-driver/amazon/aws-efs-csi-driver",<br/>  "csiProvisioner": "public.ecr.aws/eks-distro/kubernetes-csi/external-provisioner",<br/>  "livenessProbe": "public.ecr.aws/eks-distro/kubernetes-csi/livenessprobe",<br/>  "nodeDriverRegistrar": "public.ecr.aws/eks-distro/kubernetes-csi/node-driver-registrar"<br/>}</pre> | no |
| <a name="input_addons_aws_efs_csi_driver_image_repository_tag"></a> [addons\_aws\_efs\_csi\_driver\_image\_repository\_tag](#input\_addons\_aws\_efs\_csi\_driver\_image\_repository\_tag) | AWS EFS CSI Driver image tag | `map(string)` | <pre>{<br/>  "controller": "v2.1.6",<br/>  "csiProvisioner": "v5.1.0-eks-1-31-5",<br/>  "livenessProbe": "v2.14.0-eks-1-31-5",<br/>  "nodeDriverRegistrar": "v2.12.0-eks-1-31-5"<br/>}</pre> | no |
| <a name="input_addons_aws_efs_csi_driver_version"></a> [addons\_aws\_efs\_csi\_driver\_version](#input\_addons\_aws\_efs\_csi\_driver\_version) | AWS EFS CSI Driver Helm Chart version | `string` | n/a | yes |
| <a name="input_addons_aws_load_balancer_image_repository"></a> [addons\_aws\_load\_balancer\_image\_repository](#input\_addons\_aws\_load\_balancer\_image\_repository) | Load Balancer image repository | `string` | `"public.ecr.aws/eks/aws-load-balancer-controller"` | no |
| <a name="input_addons_aws_load_balancer_image_repository_tag"></a> [addons\_aws\_load\_balancer\_image\_repository\_tag](#input\_addons\_aws\_load\_balancer\_image\_repository\_tag) | Load Balancer image tag | `string` | `"v2.11.0"` | no |
| <a name="input_addons_aws_load_balancer_version"></a> [addons\_aws\_load\_balancer\_version](#input\_addons\_aws\_load\_balancer\_version) | EKS AWS Load Balancer Helm Chart version | `string` | `"1.6.2"` | no |
| <a name="input_addons_cert_manager_enabled"></a> [addons\_cert\_manager\_enabled](#input\_addons\_cert\_manager\_enabled) | if true cert-manager is enabled | `bool` | `true` | no |
| <a name="input_addons_cert_manager_image_repository"></a> [addons\_cert\_manager\_image\_repository](#input\_addons\_cert\_manager\_image\_repository) | Cert Manager image repository | `list(string)` | <pre>[<br/>  "quay.io/jetstack/cert-manager-controller",<br/>  "quay.io/jetstack/cert-manager-cainjector",<br/>  "quay.io/jetstack/cert-manager-webhook"<br/>]</pre> | no |
| <a name="input_addons_cert_manager_image_repository_tag"></a> [addons\_cert\_manager\_image\_repository\_tag](#input\_addons\_cert\_manager\_image\_repository\_tag) | Cert Manager image tag | `string` | `"v1.17.1"` | no |
| <a name="input_addons_cert_manager_version"></a> [addons\_cert\_manager\_version](#input\_addons\_cert\_manager\_version) | Cert Manager operator Helm Chart version | `string` | `"1.13.3"` | no |
| <a name="input_addons_external_dns_image_repository"></a> [addons\_external\_dns\_image\_repository](#input\_addons\_external\_dns\_image\_repository) | External DNS image repository | `string` | `"registry.k8s.io/external-dns/external-dns"` | no |
| <a name="input_addons_external_dns_image_repository_tag"></a> [addons\_external\_dns\_image\_repository\_tag](#input\_addons\_external\_dns\_image\_repository\_tag) | External DNS image tag | `string` | `"v0.15.1"` | no |
| <a name="input_addons_external_dns_version"></a> [addons\_external\_dns\_version](#input\_addons\_external\_dns\_version) | n/a | `string` | `"1.14.3"` | no |
| <a name="input_addons_external_secrets_image_repository"></a> [addons\_external\_secrets\_image\_repository](#input\_addons\_external\_secrets\_image\_repository) | External Secrets image repository | `string` | `"oci.external-secrets.io/external-secrets/external-secrets"` | no |
| <a name="input_addons_external_secrets_image_repository_tag"></a> [addons\_external\_secrets\_image\_repository\_tag](#input\_addons\_external\_secrets\_image\_repository\_tag) | External Secrets image tag | `string` | `"v0.14.2"` | no |
| <a name="input_addons_external_secrets_version"></a> [addons\_external\_secrets\_version](#input\_addons\_external\_secrets\_version) | n/a | `string` | `"0.9.11"` | no |
| <a name="input_addons_helm_repository_password"></a> [addons\_helm\_repository\_password](#input\_addons\_helm\_repository\_password) | credentials (password) for helm repositories hosted in github.com | `string` | `null` | no |
| <a name="input_addons_helm_repository_username"></a> [addons\_helm\_repository\_username](#input\_addons\_helm\_repository\_username) | credentials (username) for helm repositories hosted in github.com | `string` | `null` | no |
| <a name="input_addons_helm_timeout"></a> [addons\_helm\_timeout](#input\_addons\_helm\_timeout) | helm release timeout seconds (default 1800 sec -> 30 min) | `number` | `1800` | no |
| <a name="input_addons_karpenter_nodepools_path"></a> [addons\_karpenter\_nodepools\_path](#input\_addons\_karpenter\_nodepools\_path) | Karpenter's provisioners path | `string` | `""` | no |
| <a name="input_addons_karpenter_version"></a> [addons\_karpenter\_version](#input\_addons\_karpenter\_version) | Karpenter Helm Chart version | `string` | `"v0.34.0"` | no |
| <a name="input_addons_karpenter_volumeSize"></a> [addons\_karpenter\_volumeSize](#input\_addons\_karpenter\_volumeSize) | Karpenter's volumeSize | `string` | `"10Gi"` | no |
| <a name="input_addons_metrics_server_image_repository"></a> [addons\_metrics\_server\_image\_repository](#input\_addons\_metrics\_server\_image\_repository) | Metrics Server image repository | `string` | `"registry.k8s.io/metrics-server/metrics-server"` | no |
| <a name="input_addons_metrics_server_image_repository_tag"></a> [addons\_metrics\_server\_image\_repository\_tag](#input\_addons\_metrics\_server\_image\_repository\_tag) | Metrics Server image tag | `string` | `"v0.7.2"` | no |
| <a name="input_addons_metrics_server_version"></a> [addons\_metrics\_server\_version](#input\_addons\_metrics\_server\_version) | n/a | `string` | `"3.12.0"` | no |
| <a name="input_addons_reloader_chart_version"></a> [addons\_reloader\_chart\_version](#input\_addons\_reloader\_chart\_version) | Reloader Helm Chart version | `string` | `"1.0.56"` | no |
| <a name="input_addons_reloader_enabled"></a> [addons\_reloader\_enabled](#input\_addons\_reloader\_enabled) | Enable Stakater Reloader | `bool` | `false` | no |
| <a name="input_addons_reloader_image_repository"></a> [addons\_reloader\_image\_repository](#input\_addons\_reloader\_image\_repository) | Reloader image repository | `string` | `"ghcr.io/stakater/reloader"` | no |
| <a name="input_addons_reloader_image_repository_tag"></a> [addons\_reloader\_image\_repository\_tag](#input\_addons\_reloader\_image\_repository\_tag) | Reloader image tag | `string` | `"v1.0.56"` | no |
| <a name="input_addons_reloader_version"></a> [addons\_reloader\_version](#input\_addons\_reloader\_version) | Stakater Reloader Helm Chart version | `string` | `"1.0.56"` | no |
| <a name="input_addons_velero_bucket_arn"></a> [addons\_velero\_bucket\_arn](#input\_addons\_velero\_bucket\_arn) | if addons\_velero\_create\_bucket is false then we need to provide the bucket arn | `string` | `null` | no |
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