output "kubeconfig" {
  value = "gcloud container clusters get-credentials ${module.gke.cluster_name} --region ${module.gke.cluster_location} --project ${var.project_id}"
  description = "Command to get kubeconfig for the GKE cluster"
}
