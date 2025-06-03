terraform {
  backend "remote" {
    organization = "AdhamBasheir"

    workspaces {
      name = "infra"
    }
  }
}

module "main" {
  source = "./main"
}

// output.tf
output "kubeconfig" {
  value       = "gcloud container clusters get-credentials ${module.main.gke_info.cluster_name} --region ${module.main.gke_info.cluster_location} --project ${module.main.general_info.project_id}"
  description = "Command to get kubeconfig for the GKE cluster"
}

output "argocd_admin_password" {
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
  description = "Command to retrieve the initial admin password for ArgoCD"
}

output "general_info" {
  value       = module.main.general_info
  description = "General information about the project, region, and zone"
}

output "gke_info" {
  value       = module.main.gke_info
  description = "Information about the GKE cluster"
}
