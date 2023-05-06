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
3. Are the required controllers install so applications can be safely exposed to the world (lb/ingress/cert_manager...) ?
4. Is ArgoCD installed and can operate the cluster ?
5. Is prometheus operator installed and can access apps ?
6. Is Loki installed so it can collect logs ?
7. Is Grafana able to access Loki ?

### eksctl

TODO

### Terraform

TODO
