terraform {
  backend "remote" {
    organization = "AdhamBasheir"

    workspaces {
      name = "platform"
    }
  }
}

module "argocd" {
  source                 = "./modules/argocd"
  cluster_endpoint       = local.cluster_endpoint
  cluster_ca_certificate = local.cluster_ca_certificate
}

module "monitoring" {
  source                 = "./modules/monitoring"
  cluster_endpoint       = local.cluster_endpoint
  cluster_ca_certificate = local.cluster_ca_certificate
}
