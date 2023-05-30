# created namespace first because namespace creation
# in helm chart didn't work consistently and threw
# errors
# resource "kubernetes_namespace" "doppler_namespace" {
#   metadata {
#     name = "doppler-operator-system"
#   }

#   depends_on = [
#     kubernetes_namespace.argocd_namespace
#   ]
# }

# resource "helm_release" "doppler_operator" {
#   namespace        = "doppler-operator-system"
#   name             = "doppler"
#   repository       = "https://helm.doppler.com"
#   chart            = "doppler-kubernetes-operator"
#   version          = "1.2.5"

#   depends_on = [
#     kubernetes_namespace.doppler_namespace
#   ]
# }