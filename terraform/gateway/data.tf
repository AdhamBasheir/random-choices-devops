data "kubernetes_service" "contour_envoy" {
  metadata {
    name      = "contour-envoy"
    namespace = "project-gateway"
  }

  depends_on = [helm_release.contour]
}
