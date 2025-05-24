output "kubeconfig" {
  value = "Run: gcloud container clusters get-credentials ${var.cluster_name} --region ${var.region}"
}

output "cluster_endpoint" {
  value = module.gke.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.gke.cluster_ca_certificate
}
