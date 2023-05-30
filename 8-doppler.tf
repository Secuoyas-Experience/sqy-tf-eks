resource "helm_release" "doppler_operator" {
  name             = "doppler"
  repository       = "https://helm.doppler.com"
  chart            = "doppler-kubernetes-operator"
  version          = "1.2.5"

  depends_on = [
    kubernetes_namespace.doppler_namespace
  ]
}