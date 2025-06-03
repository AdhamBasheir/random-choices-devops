output "kubeconfig" {
  value       = "gcloud container clusters get-credentials ${module.gke.cluster_name} --region ${module.gke.cluster_location} --project ${var.project_id}"
  description = "Command to get kubeconfig for the GKE cluster"
}

output "argocd_admin_password" {
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
  description = "Command to retrieve the initial admin password for ArgoCD"
}

output "general_info" {
  value = {
    project_id = var.project_id
    region     = var.region
    zone       = var.zone
  }
  description = "General information about the project, region, and zone"
}

output "gke_info" {
  value = {
    cluster_name           = module.gke.cluster_name
    cluster_location       = module.gke.cluster_location
    cluster_endpoint       = module.gke.cluster_endpoint
    cluster_ca_certificate = module.gke.cluster_ca_certificate
  }
  description = "Information about the GKE cluster"
}
