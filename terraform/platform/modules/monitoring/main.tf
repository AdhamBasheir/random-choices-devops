resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  namespace        = var.namespace
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = var.prometheus_chart_version

  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}
