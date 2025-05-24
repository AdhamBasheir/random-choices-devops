output "kubeconfig" {
  value = "Run: gcloud container clusters get-credentials ${var.cluster_name} --region ${var.region}"
}
