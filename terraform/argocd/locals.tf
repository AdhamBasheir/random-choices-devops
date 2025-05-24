data "local_file" "argocd_application_yaml" {
  filename = "${path.module}/apps/argocd-application.yaml"
}

data "local_file" "argocd_gateway-api_yaml" {
  filename = "${path.module}/apps/argocd-gateway-api.yaml"
}
