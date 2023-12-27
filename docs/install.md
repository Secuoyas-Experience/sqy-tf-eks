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
module "secuoyas-dev-eks" {
    source                  = "git@github.com:Secuoyas-Experience/sqy-tf-eks.git?ref=v1.1.1"
    cluster_domain          = "k8s.domain.com"
    cluster_region          = "eu-central-1"
    cluster_name            = "k8s-domain-com"
    organization            = "k8s"
    environment             = "dev"
    cluster_azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
    cluster_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    cluster_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
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