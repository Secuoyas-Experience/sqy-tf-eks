# Grafana

[Grafana](https://grafana.com/docs/grafana/latest/) enables you to query, visualize, alert on, and explore your metrics, logs, and traces wherever they are stored.
Grafana OSS provides you with tools to turn your time-series database (TSDB) data into insightful graphs and visualizations.

Altough the prometheus operator we mentioned in the previous section already installs a grafana deployment, there is the [Grafana operator](https://grafana-operator.github.io/grafana-operator/docs/installation/helm/).

## Ingress

If you'd like to expose Grafana to the world you can create an ingress:

```
kubectl apply -f tools/grafana/ingress.yml
```

## Config

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