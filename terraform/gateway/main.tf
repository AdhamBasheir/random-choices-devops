resource "helm_release" "contour" {
  name       = "contour"
  namespace  = "projectcontour"
  create_namespace = true

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "contour"
  version    = "15.1.1"

  values = [
    file("${path.module}/values.yaml")
  ]
}
