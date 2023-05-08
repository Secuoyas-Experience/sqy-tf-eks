# Certificates

All our exposed tools and applications should be exposed safely. For that we should be
using certificates. Kubernetes uses the concept of ClusterIssuer & Issuer to issue
certificates for those applications requiring the use of certificates.

In order to use certificates we have to make sure our cluster have a certificate
manager operator installed. The most common operator is [cert-manager](https://cert-manager.io/)

Altough

## Letscrypt

Letscrypt is the most popular opensource free solution to get a valid SSL certificate for
our applications. The cert-manager operator allows us to create certificates issued by
Letscrypt. 

- create a Letscrypt issuer
- create an ingress annotated with name name of the issuer
- profit

First make sure you have already a Letscrypt issuer in your cluster. There are two kinds
of issuer resources:

- **Issuer**: a namespace scoped issuer
- **ClusterIssuer**: a cluster scoped issuer

For example this is a Letscrypt's `ClusterIssuer`:

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: hola@secuoyas.com
    privateKeySecretRef:
      name: letsencrypt-staging
    solvers:
    - http01:
       ingress:
         class: nginx
```

You can apply this `ClusterIssuer`:

```
kubectl apply -f clusters/cluster-issuer
``

This is a Letscrypt issuer based on the http01 protocol, which will be exposing
a token that Letscrypt can validate when the application is properly
exposed via the configured internet domain name.

Next is to create the `Ingress` exposing the application in a specific
internet domain name, and asking for a certificate to be able to redirect
trafic via a https connection:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: grafana-ingress
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-staging"
    kubernetes.io/ingress.class: "nginx"
spec:
  tls:
  - hosts:
    - grafana.lab.secuoyas.com
    secretName: grafana-tls
  rules:
    - host: grafana.lab.secuoyas.com
      http:
        paths:
          - pathType: Prefix
            path: "/"
            backend:
              service:
                name: grafana-server
                port:
                  number: 80
      https:
        paths:
          - pathType: Prefix
            path: "/"
            backend:
              service:
                name: grafana-server
                port:
                  number: 443
```

See how the annotations:

```yaml
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-staging"
    kubernetes.io/ingress.class: "nginx"
```

Tell kubernetes to use the issuer `letsencrypt-staging` issuer to create
a ssl certificate for this ingress.

**References**

- https://cert-manager.io/
- https://letsencrypt.org/
- https://letsencrypt.org/docs/challenge-types/#http-01-challenge
- https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes