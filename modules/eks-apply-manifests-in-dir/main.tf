resource "kubectl_manifest" "extra_manifests" {
  for_each  = toset(var.manifests)
  yaml_body = file(each.value)
}