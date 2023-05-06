# Monitoring

## ArgoCD

TODO

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