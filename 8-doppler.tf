# resource "helm_release" "doppler_operator" {
#   namespace        = "doppler-operator-system"
#   create_namespace = true
#   name             = "doppler"
#   repository       = "https://helm.doppler.com"
#   chart            = "doppler-kubernetes-operator"
#   version          = "1.2.5"

#   depends_on = [
#     kubernetes_namespace.argocd_namespace
#   ]
# }