# Griddo

At the moment, Griddo components will be installed as kubernetes manifests, using kustomize to customize the installation depending
on the environment we are going to deploy these components. There will be:

- `base`: folder where the common deployment information is located
- `overlays`: customizations for each environment

For instance, to deploy Griddo in a local kubernetes cluster:

```
kubectl -n griddo apply -k k8s/overlays/local
```

Anyway the idea is to deploy Griddo instances via ArgoCD in order to keep the environments always in sync.