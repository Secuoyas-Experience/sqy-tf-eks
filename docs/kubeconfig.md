# Kubeconfig

Una vez se ha instalado el cluster para acceder al cluster debemos conseguir las credenciales del cluster para poder interactuar con el. Estas credenciales o configuracion de kube, de ahi kubeconfig podemos conseguirlas una vez finalizada la instalacion usando el siguiente comando:

```shell
aws eks update-kubeconfig \
    --name <cluster_name> \
    --profile <aws_profile> \
    --region <aws_region> \
    --role-arn arn:aws:iam::{account-id}:role/<cluster_name>-kube-admin \
    --alias <kube_config_alias>
```

- **cluster_name**: suele ser el nombre del cluster con el que se ha dado de alta en EKS
- **profile**: el profile con el que autenticarte contra AWS. Tiene que tener permisos de administrador
- **account-id**: AWS account id donde esta creado el cluster
- **kube_config_alias**: Es un alias con el que registrar las credenciales de kubernetes en tu kube config local. Puede ser el que quieras pero recomendamos que sea el mismo que el cluster name pero cambiando los guiones `-` por puntos `.`, es decir, un cluster con nombre `secuoyas-dev-eks` seria `secuoyas.dev.eks`.

Esto actualizara tu fichero `~/.kube/config` con las credenciales necesarias para acceder al contexto de tu cluster. Para ver que tienes dado de alta ese contexto en tu kubeconfig puedes listar los contextos a los que tienes acceso ejecutando:

```shell
kubectl config get-contexts
```