# Secuoyas K8S

To create a new cluster in AWS these are the required steps to follow:

1. CREATE NODE (Terraform > eksctl)
3. ADD AWS LOAD BALANCER CONTROLLER (required to automate lb creation)
4. ADD ARGOCD TO tools NODEGROUP
5. ADD PROMETHEUS OPERATOR TO tools NODEGROUP (opt)
6. ADD LOKI TO tools NODEGROUP (opt)
7. ADD GRAFANA TO tools NODEGROUP (opt)
8. ADD GRIDDO TO apps NODEGROUP

## Create Node

To create the cluster we will be using [eksctl](https://eksctl.io/). It is the easiest way
of creating a cluster of k8s in AWS.

**Characteristics**:

- region: eu-central-1
- kubernetes version: 1.24

## Adding AWS Load Balancer Controller

In order to be able to expose application to the rest of the world we need a 
load balancer. In order to do that we need to install the AWS load balancer
controller.

Follow the instructions at the official [https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.5/](AWS Load Balancer Controller).

First you have to install the `cert-manager`:

```
kubectl apply --validate=false -f clusters/aws_alb/v1_5_4_cert-manager.yaml
```

Then the `aws_load_balancer_controller`

**BEFORE APPLYING THE NEXT MANIFEST**: you have to make sure the `--cluster-name`
parameter has the name of the cluster we've just created.


```yaml
apiVersion: apps/v1
kind: Deployment
. . .
name: aws-load-balancer-controller
namespace: kube-system
spec:
    . . .
    template:
        spec:
            containers:
                - args:
                    - --cluster-name=<INSERT_CLUSTER_NAME>

```

And apply the edited manifest:

```
kubectl apply -f clusters/aws_alb/v2_5_1_full.yaml
```

And finally, the `ingress class` manifest:

```
kubectl apply -f clusters/aws_alb/v2_5_1_ingclass.yaml
```

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

### Grafana

[See section here](./docs/grafana.md)

### Loki

[Loki](https://grafana.com/oss/loki/) is a log aggregation system designed to store and query logs from all your applications and infrastructure.

## ArgoCD

[ArgoCD](https://argo-cd.readthedocs.io/en/stable/) is a declarative, GitOps continuous delivery tool for Kubernetes. It will help
us deploying and orchestrating kubernetes based work.

### Deployment

We can deploy the latest stable ArgoCD release by executing:

```
kubectl create namespace argocd
kubectl apply -n argocd -f tools/argocd/argocd_v2.6.7.yaml
```

It's recommended to install the [argocd cli](https://argo-cd.readthedocs.io/en/stable/getting_started/#2-download-argo-cd-cli).

Now if you'd like to open the web console locally, fist get the initial password:

```
argocd admin initial-password
```

And then you can use port-forwarding:

```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

To see more go to the [Getting started](https://argo-cd.readthedocs.io/en/stable/getting_started/) chapter.

### Monitoring

Argo CD exposes different sets of Prometheus metrics per server. You can add prometheus metrics by
executing:

```
kubectl apply -f tools/monitoring/argocd
```

[Check the latest documentation](https://argo-cd.readthedocs.io/en/stable/operator-manual/metrics/) about monitoring.

## Griddo

At the moment, Griddo components will be installed as kubernetes manifests, using kustomize to customize the installation depending
on the environment we are going to deploy these components. There will be:

- `base`: folder where the common deployment information is located
- `overlays`: customizations for each environment

For instance, to deploy Griddo in a local kubernetes cluster:

```
kubectl -n griddo apply -k k8s/overlays/local
```

Anyway the idea is to deploy Griddo instances via ArgoCD in order to keep the environments always in sync.