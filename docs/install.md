# Instalacion

## Credenciales AWS

Antes de ejecutar terraform debemos tener en nuestra maquina las credenciales contra la organizacion de AWS en la que queremos instalar la nueva infraestructura. Podemos utilizar varias formas de autenticacion contra AWS, aunque recomendamos utilizar SSO:

```shell
aws sso login --profile profileName
```

Esto abrira el navegador contra el endpoint de nuestro SSO para la organizacion en la que queremos aplicar los cambios. Una vez autenticado contra el SSO nos preguntara si queremos autenticar nuestro cliente de AWS local. Si lo autorizamos a partir de este momento podemos ejecutar Terraform contra esa organizacion con los permisos que tenga el usuario con el que nos hemos autenticado.

Independientemente del metodo de autenticacion que utilices, a partir de este momento utiliza la variable `AWS_PROFILE` para todas las ejecuciones de terraform. De esta manera evitaras ejecutar Terraform en una organizacion distinta a la que quieres usar.

!!! warning

    Este paso es muy importante, al trabajar contra diferentes organizaciones, si no somos explicitos utilizando esta variable cuando usamos Terraform podriamos borrar o instalar algo en una organizacion en la que no deberiamos estar haciendolo. Asi que ojo con esto.

## Usage

Para usar este modulo declara el modulo en tu proyecto pasandole las variables obligatorias (ver [Inputs](#inputs)):

```ruby
module "cluster" {
  source                     = "git@github.com:Secuoyas-Experience/sqy-tf-eks.git?ref=v1.8.0"
  cluster_name               = "my-domain-es"
  cluster_kubernetes_version = "1.29"
  cluster_cidr               = "10.0.0.0/16"
  cluster_region             = "eu-central-1"
  cluster_azs                = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  cluster_private_subnets    = ["10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/24"]
  cluster_public_subnets     = ["10.0.192.0/24", "10.0.193.0/24", "10.0.194.0/24"]
  inception_min_size         = 1
  inception_max_size         = 2
  inception_desired_size     = 2
  environment                = "dev"
  organization               = "my.domain.es"
}
```

Una vez establezcas los valores deseados, puedes pasar a [instalar](#instalacion) el modulo contra la organizacion elegida.

## Inputs

Las variables de configuracion

```ruby
--8<-- "base-1-variables.tf"
```

## Instalar

Para empezar debemos instalar aquellos plugins o providers de los que dependa nuestra instalacion. Para ello debemos inicializar Terraform.

```shell
AWS_PROFILE=profileName terraform init
```

Una vez se han instalado los modulos y plugins, debemos asegurarnos de que formalmente nuestra instalacion es correcta.

!!! note

    Al ser una validacion formal es mucho mas rapida que ejecutar `terraform plan` y suele servir para descartar errores de sintaxis o errores de asignacion de variables.

```shell
AWS_PROFILE=profileName terraform validate
```

A continuacion validamos que la instalacion va a poder realizarse de manera correcta. Esta vez Terraform hara peticiones a AWS para asegurarse de que al final podra instalar todo lo que queremos instalar. Como resultado de ejecutar `terraform plan` se mostrara el numero de recursos que se van a instalar/modificar/borrar

```shell
AWS_PROFILE=profileName terraform plan
```

Si estamos conformes con el resultado del plan podemos ejecutar `terraform apply`. Terraform apply volvera a ejecutar por debajo `terraform plan` y nos preguntara si queremos seguir. Solo si contestamos `yes` ejecutara el plan contra AWS.

```shell
AWS_PROFILE=profileName terraform apply
```

## Modulos

El modulo principal crea un cluster EKS con una serie de addons:

- vpc-cni
- aws-ebs-csi-driver
- coredns
- kube-proxy

Ademas de inicializar con worker nodes el numero de nodegroups que se haya configurado por parametros. Pero si se quiere instalar los addons extras:

- velero
- argocd
- argocd-events
- aws-load-balancer
- external-dns
- external-secrets
- reloader

Se deben utilizar otra serie de modulos que se encuentran en la carpeta [modules][../../modules]

## Ejemplos

Puedes ver ejemplos en https://github.com/Secuoyas-Experience/sqy-tf-eks/tree/feat/extract_velero_bucket_and_dns_zones/examples/cluster-with-addons