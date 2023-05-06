# ArgoCD

[ArgoCD](https://argo-cd.readthedocs.io/en/stable/) is a declarative, GitOps continuous delivery tool for Kubernetes. It will help
us deploying and orchestrating kubernetes based work.

## Deployment

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

## Monitoring

Argo CD exposes different sets of Prometheus metrics per server. You can add prometheus metrics by
executing:

```
kubectl apply -f tools/monitoring/argocd
```

[Check the latest documentation](https://argo-cd.readthedocs.io/en/stable/operator-manual/metrics/) about monitoring.