# Tools

## What is a tool ?

Grafana, Airflow, Backstage...

## Common 

### Persistent volumes

We need to provision **P**ersistent **V**olumes (pv/pvs from now own) like a pool of disk that
the pods may use to store information into.

Depending on the environment (AWS, GCP, Azure...etc) the configuration may vary. We will be
using **kustomize** to apply the specific configuration for each environment. This is the
persistent volume declaration for minikube:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: tools-storage
spec:
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 5Gi
  hostPath:
    path: /data/tools/
```

We are declaring that there is a disk pods considered as tools can use. In total they will
have 5Gi. 

**Maybe it will be a better idea to have pvc for each tool as it seems easier to
calculate**.