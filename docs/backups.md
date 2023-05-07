# Backups

## Gemini

- **Kubernetes**: 1.25
- **Gemini Helm Chart**: 2.0.0

Gemini is a backup service that creates snapshots of persistent volume claims. 

### Install

Gemini can be installed via Helm chart:

```
kubectl create ns gemini
helm repo add fairwinds-stable https://charts.fairwinds.com/stable
helm install gemini fairwinds-stable/gemini --namespace gemini
```

More information at the [github repository](https://github.com/FairwindsOps/gemini).

### Usage

You can create backups (snapshots) via manifests like this one:

```yaml
apiVersion: gemini.fairwinds.com/v1
kind: SnapshotGroup
metadata:
  name: grafana-database-backup
  namespace: monitoring
spec:
  persistentVolumeClaim:
    claimName: grafana-database-pvc
  schedule:
    - every: 10 minutes
      keep: 2
```

In this manifest we want Gemini to create snapshots every 10 minutes of the `grafana-database-pvc` resource, which
is a persistent volume claim, located in the `monitoring` namespace.

You can also create a backup whenever you want through the Gemini CLI.


**References**

- https://github.com/FairwindsOps/gemini
- https://www.fairwinds.com/blog/gemini-automate-backups-of-persistentvolumes-in-kubernetes


## Minio/Velero

TODO

- https://velero.io/docs/main/contributions/minio/


## CronJobs

TODO