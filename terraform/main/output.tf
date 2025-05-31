output "kubeconfig" {
  value = "gcloud container clusters get-credentials ${module.gke.cluster_name} --region ${var.region} --project ${var.project_id}"
  # value = "gcloud container clusters get-credentials ${module.gke.cluster_name} --region ${module.gke.location} --project ${var.project_id}"
  description = "Command to get kubeconfig for the GKE cluster"
}
