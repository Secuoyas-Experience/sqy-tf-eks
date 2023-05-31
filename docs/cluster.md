# Cluster EKS

## Instalacion

Una vez hemos terminado la creacion de un nuevo cluster de Kubernetes, nuestro cluster deberia estar compuesto por:

1. Un nodo de Kubernetes
2. Addons (AWS Load balancer, VPC CNI, EBS CNI)
3. ArgoCD
4. External DNS
5. Karpenter
6. Prometheus operator & Grafana
7. Doppler
8. Velero

### Terraform

Para la creacion del cluster estamos utilizando [Terraform](https://www.terraform.io):

- IaC (infraestructura como codigo)
- Mantiene un estado de lo que instala y lo que no
- Nos permite instalar diferentes tipos de recursos (manifiestos de kubernetes, recursos de AWS, repositorios de Git...)

Anteriormente para crear un nuevo cluster se utilizaba [eksctl](https://eksctl.io/), y aunque es la forma mas sencilla de crear un cluster de EKS, no nos permitia facilmente complementarlo con otro tipo de recursos sin tener que utilizar otra herramienta.

```
terraform init
```

```
terraform plan
```

```
terraform apply -auto-approve
```

La instalacion tarda unos 15 min en crear el nuevo cluster. Una vez el cluster ha sido creado, para poder operar con el se ha de configurar el fichero `~/.kube/conf` con las credenciales para el nuevo cluster:

```
aws eks update-kubeconfig --name <cluster_name> --profile <aws_profile> --role-arn arn:aws:iam::{account-id}:role/toolbox-kube-admin --alias <kube_config_alias>
```

Para comprobar que se han generado correctamente:

```
kubectl --context <kube_config_alias> get nodes
```