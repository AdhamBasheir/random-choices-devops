resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = var.namespace
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = var.argocd_version

  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}

# resource "kubernetes_manifest" "argocd_application" {
#   manifest = yamldecode(data.local_file.argocd_application_yaml.content)
# }

# resource "kubernetes_manifest" "argocd_gateway_api" {
#   manifest = yamldecode(data.local_file.argocd_gateway-api_yaml.content)
# }
