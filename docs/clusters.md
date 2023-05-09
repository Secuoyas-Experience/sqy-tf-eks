# Clusters

## Creating a new cluster

To create the cluster at the moment we will be using [eksctl](https://eksctl.io/). It is the easiest way of creating a cluster of k8s in AWS.

There are a **very important questions** that devops team has to review  before considering a cluster has been propery configured.

1. Are the nodes created (Terraform/EKSctl) ?
3. Are the required controllers/CRDs installed so applications can be safely exposed to the world (lb/ingress/cert_manager/volumesnapshots...) ?
4. Is ArgoCD installed and can operate the cluster ?
5. Is prometheus operator installed and can access apps ?
6. Is Loki installed so it can collect logs ?
7. Is Grafana able to access Loki ?

### EKS

For other than local, at the moment we are using [eksctl](https://eksctl.io/) CLI to create kubernetes environments in AWS (EKS).

To create a new cluster, first create the cluster definition in `clusters` folder and then
execute the definition with:

```
eksctl --profile <aws_profile_in_credentials> create -f clusters/<cluster_name>/eks.yaml
```

It takes around 15 min to create a new cluster. Once the cluster has been created your 
`~/.kube/conf` config file will be updated with the new cluster's credentials.

#### Cluster Domain and Certs

If you cluster is going to serve applications exposed to the outside world you may want to provision some domain names and certificates for them. This is done with Terraform.

```
terraform init
terraform validate
terraform apply
```

#### AWS Load Balancer

Is important to install a basic set of tools to our new cluster in order to make it fully
functional.

- AWS load balancer controller
- Cert Manager
- Prometheus monitoring (with Grafana)

The AWS Load Balancer controller enables EKS to create load balancers when a certain
kubernetes resource need them. For instance if we are creating a web application that requires
to be exposed to the world via an ALB we can eventually annotate an Ingress deploy the
application to K8s and it will create a load balancer in the background.

```
kubectl --context <name_of_cluster> apply -k tools/aws/alb/overlays/<name_of_cluster>
```

#### Prometheus monitoring

Next is to make sure prometheus monitoring is up and running in the cluster to monitor all our tools and apps will be
properly monitored.

Apply first the `setup` folder with all the CRDs. And then apply the `toolbox` overlay to 
install the deployments.

```
kubectl --context <name_of_cluster> create -f tools/prometheus/setup
kubectl --context <name_of_cluster> create -k tools/prometheus/manifests/overlays/<name_of_cluster>
```

The default username/password for grafana is `admin/admin`. Right after login in Grafana will ask you to change the
password.

**DNS -> GRAFANA**

At the moment the mapping of the domain name to the grafana instance is done with Terraform. So
once Grafana is up and running make sure you execute Terraform.

#### ArgoCD

ArgoCD is the reference tool use to operate the rest of the tools & apps. To install it just execute:

```
kubectl --context <name_of_cluster> apply -k tools/argocd/overlays/<name_of_cluster>
```

This will install argocd in the cluster and will add the ArgoCD's prometheus monitoring as well.

### Minikube

[Minikube](https://minikube.sigs.k8s.io/docs/start/) is local Kubernetes, focusing on making it easy to learn and develop for Kubernetes.


#### Addons 

In order to be able to work in a similar setup as production we recommend to enable the following addons:

```
minikube addons enable ingress
minikube addons enable volumesnapshots
```

#### Prometheus monitoring

Same steps as EKS installation

There is an Ingress configured to access the grafana app, and it points to `grafana.secuoyas.local`. You can map your
`/etc/hosts` (Linux) to make your computer to point at the right ip:

```
192.168.49.2    grafana.secuoyas.local
```

#### ArgoCD

This time use `minikube` overlay:

```
kubectl --context <name_of_cluster> apply -k tools/argocd/overlays/minikube
```

There is an Ingress configured to access the argocd app, and it points to `argocd.secuoyas.local`. You can map your
`/etc/hosts` (Linux) to make your computer to point at the right ip:

```
192.168.49.2    argocd.secuoyas.local
```

## Destroying a cluster

To destroy a cluster you can execute the following snippet, but keep in mind that
**IT WON'T ASK YOU FOR CONFIRMATION**:

```
eksctl --profile <aws_profile_name> delete cluster -f clusters/<name_of_cluster>/eks.yaml
```