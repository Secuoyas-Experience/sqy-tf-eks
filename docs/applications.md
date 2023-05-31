# Despliegue de applicaciones

## ArgoCD

[ArgoCD](https://argo-cd.readthedocs.io/en/stable/) es una herramienta de entrega continua declarativa, que emplea la filosofia GitOps y Kubernetes. Esta herramienta nos ayudara a desplegar nuestras applicaciones en nuestro cluster de kubernetes.

Vamos a utilizar ArgoCD y Gitops para desplegar las aplicaciones en nuestro cluster:

- Creamos un repositorio con las definiciones de los proyectos que queremos desplegar
- Informaremos a ArgoCD de este repositorio
- ArgoCD leera y tomara el mando desde ese momento para instalar y actualizar esas aplicaciones

Cualquier cambio que queramos hacer en nuestras aplicaciones debera hacerse mediante la modificacion de ficheros a traves del control de versiones de Git.

### Doppler token secret

TODO

### Login

Una vez que hemos dado de alta el secreto que permitira a ArgoCD conseguir las credenciales para poder leer los repositorios privados, podemos decirle a ArgoCD cual es el repositorio donde se definen los proyectos que queremos que maneje.

Para ello debemos entrar en ArgoCD a traves de su aplicacion web. Esta aplicacion no va a estar expuesta al mundo exterior por lo que debemos realizar un tunel a nuestra maquina para poder verlo. 

```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Ahora si, podemos abrir nuestro navegador en el puerto 8080 y podremos ver la pantalla de login de ArgoCD. Para poder saber el password inicial de nuestra instancia de ArgoCD podemos ejecutar:

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Eso nos devolvera el password (recuerda cambiarlo despues y gestionarlo con Doppler). Puedes hacer login con admin como usuario y el password que acabamos de recuperar.

### Dar de alta el proyecto origen

Ahora podemos dar de alta una aplicacion a traves de `Applications > New App`

## Monitoring

Argo CD expone diferentes conjuntos de metricas de Prometheus por cada servidor. [Revisa la documentacion aqui](https://argo-cd.readthedocs.io/en/stable/operator-manual/metrics/).