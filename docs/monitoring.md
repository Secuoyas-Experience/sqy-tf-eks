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

[Grafana](https://grafana.com/docs/grafana/latest/) enables you to query, visualize, alert on, and explore your metrics, logs, and traces wherever they are stored.
Grafana OSS provides you with tools to turn your time-series database (TSDB) data into insightful graphs and visualizations.

Altough the prometheus operator we mentioned in the previous section already installs a grafana deployment, there is the [Grafana operator](https://grafana-operator.github.io/grafana-operator/docs/installation/helm/).

### Config

That then have to be copied to the `secrets.yml` in the `data.grafana.ini` field:

```yaml
apiVersion: v1
data:
  grafana.ini: <BASE64_CONFIG_HERE>
kind: Secret
metadata:
  labels:
    component: grafana
    name: grafana
  name: grafana-config
  namespace: monitoring
type: Opaque
```

### Authentication

In order to allow Grafana to use Secuoyas' Google authentication you must add the following data to
the grafana secret.

```toml
  [server]
  root_url=https://grafana.toolbox.secuoyas.com/

  [auth.google]
  enabled=true
  allow_sign_up=true
  auto_login=false
  client_id=<CLIENT_ID>
  client_secret=<CLIENT_SECRET>
  scopes=https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email
  auth_url=https://accounts.google.com/o/oauth2/auth
  token_url=https://accounts.google.com/o/oauth2/token
  allowed_domains=grafana.toolbox.secuoyas.com secuoyas.com
  hosted_domain=secuoyas.com
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