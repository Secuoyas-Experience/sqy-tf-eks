# Monitoring

## Prometheus Operator

In order to be able to collect prometheus metrics from apps and pods we need to install the [prometheus operator](https://prometheus-operator.dev/). Installing the operator is pretty straight forward following the [quick-start](https://prometheus-operator.dev/docs/prologue/quick-start/) chapter in the official site.


Clone `kube-prometheus` repository:

```
git clone https://github.com/prometheus-operator/kube-prometheus.git
```

And the create the manifests against your cluster:

```
# Create the namespace and CRDs, and then wait for them to be availble before creating the remaining resources
kubectl create -f manifests/setup

# Wait until the "servicemonitors" CRD is created. The message "No resources found" means success in this context.
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done

kubectl create -f manifests/
```

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

### Ingress

If you'd like to expose Grafana to the world you can create an ingress:

```
kubectl apply -f tools/grafana/ingress.yml
```

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

In order to allow Grafana to use Google authentication you must add the following data to
the grafana secret.

```toml
[auth.google]
enabled = true
allow_sign_up = true
auto_login = false
client_id = CLIENT_ID
client_secret = CLIENT_SECRET
scopes = https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email
auth_url = https://accounts.google.com/o/oauth2/auth
token_url = https://accounts.google.com/o/oauth2/token
allowed_domains = mycompany.com mycompany.org
hosted_domain = mycompany.com
```

## Loki

[Loki](https://grafana.com/oss/loki/) is a log aggregation system designed to store and query logs from all your applications and infrastructure.