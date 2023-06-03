# Monitoring

## Prometheus Operator

In order to be able to collect prometheus metrics from apps and pods we need to install the [prometheus operator](https://prometheus-operator.dev/). Installing the operator is pretty straight forward following the [quick-start](https://prometheus-operator.dev/docs/prologue/quick-start/) chapter in the official site.

### Troubleshooting

In order to allow prometheus to collect metrics from services/pods/endpoints in different namespaces
other than `monitoring` we need to change the `prometheus-k8s` cluster role to this one accoding to
this [issue in Github](https://github.com/prometheus-operator/kube-prometheus/issues/483):

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: prometheus-k8s
rules:
  - apiGroups:
    - ""
    resources:
    - nodes/metrics
    verbs:
    - get
  - nonResourceURLs:
    - /metrics
    verbs:
    - get
  - apiGroups:
    - ""
    resources:
    - services
    - pods
    - endpoints
    verbs:
    - get
    - list
    - watch
```

## Grafana

[Grafana](https://grafana.com/docs/grafana/latest/) te permite consultar, visualizar, crear alertas y explirar tus metricas, logs, y trazas donde quiera que esten almacenadas. Grafana OSS nos proporciona una serie de herramientas para cambiar tus datos en graficos visualizaciones con valor.

Aunque el operador de kubernetes de Prometheus ya instala Grafana, tambien existe el operator de Kubernetes de [Grafana](https://grafana-operator.github.io/grafana-operator/docs/installation/helm/).

### Configuracion

Para configurar Grafana vamos a proporcionar toda la informacion a traves de un secreto de Kubernetes que contendra las variables de entorno de corresponden a los valores que queremos configurar. En lugar de crear un secreto directamente, lo que haremos sera:

- crear esas variables en Doppler
- crear un token en Doppler de solo lectura
- crear un `Secret` con el token Doppler en el namespace donde este instalado Doppler

```
kubectl create secret generic grafana-doppler-token-secret \
  --namespace doppler-operator-system \
  --from-literal=serviceToken=dp.st.dev.XXXX
```

- crear un `DopplerSecret` que gestione los secretos de Grafana en Kubernetes usando el token que hemos dado de alta en el paso anterior
- crear un `Secret` que usara Grafana y que se ira actualizando segun vayamos cambiando algun valor en Doppler

```yaml
--8<-- "manifests/grafana/secrets.yaml"
```

!!! warning

    Estos dos ultimos secretos los creamos de manera automatica a traves de la instalacion del cluster. Pero recuerda crear las variables con sus valores en Doppler y el secreto con el token de Doppler antes.

Estas son las variables que tenemos que gestionar desde Doppler:

```env
GF_AUTH_GOOGLE_ENABLED="true"
GF_AUTH_GOOGLE_ALLOW_SIGN_UP="false"
GF_AUTH_GOOGLE_AUTO_LOGIN="false"
GF_AUTH_GOOGLE_CLIENT_ID="<CLIENT_ID>"
GF_AUTH_GOOGLE_CLIENT_SECRET="<CLIENT_SECRET>"
GF_AUTH_GOOGLE_SCOPES="https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email"
GF_AUTH_GOOGLE_AUTH_URL="https://accounts.google.com/o/oauth2/auth"
GF_AUTH_GOOGLE_TOKEN_URL="https://accounts.google.com/o/oauth2/token"
GF_AUTH_GOOGLE_ALLOWED_DOMAINS="grafana.toolbox.secuoyas.com secuoyas.com"
GF_AUTH_GOOGLE_HOSTED_DOMAIN="secuoyas.com"

GF_SECURITY_ADMIN_EMAIL="support@secuoyas.com"
GF_SECURITY_ADMIN_PASSWORD="adminpassword"
GF_SECURITY_ADMIN_USER="admin"

GF_SERVER_ROOT_URL="https://grafana.toolbox.secuoyas.com/"
```

## Loki

[Loki](https://grafana.com/oss/loki/) is a log aggregation system designed to store and query logs from all your applications and infrastructure.

## MYSQL

### Install exporter

In order to allow prometheus to collect metrics from services/pods/endpoints in different namespaces
other than `monitoring` we need to change the `prometheus-k8s` cluster role to this one accoding to
this [issue in Github](https://github.com/prometheus-operator/kube-prometheus/issues/483):

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: prometheus-k8s
rules:
  - apiGroups:
    - ""
    resources:
    - nodes/metrics
    verbs:
    - get
  - nonResourceURLs:
    - /metrics
    verbs:
    - get
  - apiGroups:
    - ""
    resources:
    - services
    - pods
    - endpoints
    verbs:
    - get
    - list
    - watch
```

#### Prepare database

https://github.com/prometheus/mysqld_exporter

```sql
CREATE USER 'exporter'@'%' IDENTIFIED BY 'XXXXXXXX' WITH MAX_USER_CONNECTIONS 3;
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'localhost';
```

#### Prepare helm values

```yaml
replicaCount: 1

# mysql connection params which build the DATA_SOURCE_NAME env var of the docker container
mysql:
  db: ""
  host: "griddo-db"
  param: ""
  pass: "XXXXXXXX"
  port: 3306
  protocol: ""
  user: "exporter"

serviceMonitor:
  enabled: true
```