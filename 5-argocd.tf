resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name = "argocd"
  }
  depends_on = [kubectl_manifest.karpenter_template]
}

data "kubectl_file_documents" "argocd_install" {
  content = file("${path.module}/manifests/argocd/argocd-2.7.2.yaml")
}

resource "kubectl_manifest" "argocd_provisioner" {
  for_each           = data.kubectl_file_documents.argocd_install.manifests
  override_namespace = "argocd"
  yaml_body          = each.value
  depends_on         = [kubernetes_namespace.argocd_namespace]
}