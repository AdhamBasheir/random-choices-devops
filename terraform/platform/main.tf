terraform {
  backend "remote" {
    organization = "AdhamBasheir"

    workspaces {
      name = "platform"
    }
  }
}

module "main" {
  source = "./main"
}

// output.tf
output "argocd_admin_password" {
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
  description = "Command to retrieve the initial admin password for ArgoCD"
}
