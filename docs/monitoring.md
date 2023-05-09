# Monitoring

## Prometheus Operator

- **Kubernetes**: 1.25
- **Prometheus Operator**: 0.65.0

In order to be able to collect prometheus metrics from apps and pods we need to install the [prometheus operator](https://prometheus-operator.dev/). Installing the operator is pretty straight forward following the [quick-start](https://prometheus-operator.dev/docs/prologue/quick-start/) chapter in the official site.


We've copied the manifest of a specific version in this repository so that we keep track of the version compatibilities
between the operator and kubernetes versions. 

To install the operator 

```
# Create the namespace and CRDs, and then wait for them to be availble before creating the remaining resources
kubectl create -f tools/prometheus/setup

# Wait until the "servicemonitors" CRD is created. The message "No resources found" means success in this context.
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done

kubectl create -k tools/prometheus/overlays/<ENVIRONMENT>
```

Where `<ENVIRONMENT>` can be:

- minikube
- lab

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

- **Kubernetes**: 1.25
- **Prometheus Operator**: 0.65.0

[Grafana](https://grafana.com/docs/grafana/latest/) enables you to query, visualize, alert on, and explore your metrics, logs, and traces wherever they are stored.
Grafana OSS provides you with tools to turn your time-series database (TSDB) data into insightful graphs and visualizations.

Altough the prometheus operator we mentioned in the previous section already installs a grafana deployment, there is the [Grafana operator](https://grafana-operator.github.io/grafana-operator/docs/installation/helm/).

### Ingress

Depending on the environment you can open Grafana web console via web browser:

- **minikube**: http://grafana.secuoyas.local
- **lab**: https://grafana.lab.secuoyas.com

### Config

Grafana configuration is added as a Kubernetes secret. There must be a grafana secret in the
monitoring namespace:

```
kubectl get secrets -n monitoring
```

You could edit it directly (but if you have ArgoCD with sync activated it will be overriden)

```
kubectl edit secrets -n monitoring grafana-config
```

Or just modify the secret in the manifest and apply it or commit the changes to Git and leave
ArgoCD to do the sync.

```
kubectl apply -n monitoring -f tools/grafana/secrets.yml
```

In order to add the configuration as a secret to the `secrets.yml` you must add it as a base64
string. You can create your `config.toml` out of the `config.template.toml` file and then 
execute:

```
cat config.toml | base64
```

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

To apply changes you have to scale down grafana deployment:

```
kubectl --context <name_of_cluster> -n monitoring scale --replicas 0 deployment/grafana
```

Then replace configuration with new manifest:

```
kubectl --context <name_of_cluster> -n monitoring replace -f /path/to/new/grafana-config.yml
```

And then scale up again:

```
kubectl --context <name_of_cluster> -n monitoring scale --replicas 1 deployment/grafana
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

### Install chart

TODO

## Griddo

TODO