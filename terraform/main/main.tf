module "gke" {
  source       = "../gke"
  project_id   = var.project_id
  zone         = var.zone
  cluster_name = var.cluster_name
  location     = var.region
}

module "argocd" {
  source                 = "../argocd"
  cluster_endpoint       = module.gke.cluster_endpoint
  cluster_ca_certificate = module.gke.cluster_ca_certificate
}

# module "jenkins" {
#   source                 = "../jenkins"
#   cluster_endpoint       = module.gke.cluster_endpoint
#   cluster_ca_certificate = module.gke.cluster_ca_certificate
# }

module "monitoring" {
  source                 = "../monitoring"
  cluster_endpoint       = module.gke.cluster_endpoint
  cluster_ca_certificate = module.gke.cluster_ca_certificate
}
