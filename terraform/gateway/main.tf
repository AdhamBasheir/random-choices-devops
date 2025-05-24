resource "kubernetes_manifest" "gateway_api" {
  manifest = yamldecode(file("${path.module}/gateway-api.yaml"))
}

resource "kubernetes_manifest" "gateway_api_crds" {
  for_each = { for idx, doc in local.decoded_yaml : idx => doc }
  manifest = each.value
}

resource "kubernetes_manifest" "argocd_route" {
  manifest = yamldecode(file("${path.module}/argocd-route.yaml"))
}

resource "kubernetes_manifest" "jenkins_route" {
  manifest = yamldecode(file("${path.module}/jenkins-route.yaml"))
}

resource "kubernetes_manifest" "grafana_route" {
  manifest = yamldecode(file("${path.module}/grafana-route.yaml"))
}
