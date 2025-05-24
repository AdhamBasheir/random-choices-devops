resource "helm_release" "jenkins" {
  name       = "jenkins"
  namespace  = var.namespace
  chart      = "jenkins"
  repository = "https://charts.jenkins.io"
  version    = var.jenkins_version

  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}
