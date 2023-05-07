# Clusters

## Creating a new cluster

To create the cluster at the moment we will be using [eksctl](https://eksctl.io/). It is the easiest way of creating a cluster of k8s in AWS. **But the idea is to use Terraform** as it makes it safer and cleaner to 
maintain K8s clusters overtime.

A cluster must have at least 3 nodes (1 with control plane, 1 workload and 1 failover):

**Control Plane**:

- **region**: eu-central-1
- **kubernetes version**: 1.24
- **cpu**:
- **memory**:
- **labels**: control-plane

**Workload**:

- **region**: eu-central-1
- **kubernetes version**: 1.24
- **cpu**:
- **memory**:
- **labels**: workload

**Failover**:

The same as Workload nodes.

**IMPORTANT**

There are a **very important questions** that devops team has to review  before considering a cluster has been propery configured.

1. Are the nodes created (Terraform/EKSctl) ?
3. Are the required controllers/CRDs installed so applications can be safely exposed to the world (lb/ingress/cert_manager/volumesnapshots...) ?
4. Is ArgoCD installed and can operate the cluster ?
5. Is prometheus operator installed and can access apps ?
6. Is Loki installed so it can collect logs ?
7. Is Grafana able to access Loki ?

### eksctl

TODO

### Terraform

TODO


### Minikube

[Minikube](https://minikube.sigs.k8s.io/docs/start/) is local Kubernetes, focusing on making it easy to learn and develop for Kubernetes.


#### Addons 

In order to be able to work in a similar setup as production we recommend to enable the following addons:

```
minikube addons enable ingress
minikube addons enable volumesnapshots
```

#### Persistent volumes

You can apply persistent volumes for a specific environment using kubectl and kustomize. For instance to create the tools persistent volume in `minikube`:

```
kubectl apply -k tools/volumes/overlays/minikube
```

#### Prometheus monitoring

Next is to make sure prometheus monitoring is up and running in the cluster to monitor all our tools and apps will be
properly monitored.

```
kubectl create -f tools/prometheus/setup
kubectl create -k tools/prometheus/overlays/minikube
```

There is an Ingress configured to access the grafana app, and it points to `grafana.secuoyas.local`. You can map your
`/etc/hosts` (Linux) to make your computer to point at the right ip:

```
192.168.49.2    grafana.secuoyas.local
```

The default username/password for grafana is `admin/admin`. Right after login in Grafana will ask you to change the
password.

#### ArgoCD

ArgoCD is the reference tool use to operate the rest of the tools & apps. To install it just execute:

```
kubectl apply -f tools/argocd
```

This will install argocd in the cluster and will add the ArgoCD's prometheus monitoring as well.
