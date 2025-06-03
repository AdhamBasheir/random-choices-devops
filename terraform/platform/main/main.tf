module "argocd" {
  source                 = "../argocd"
  cluster_endpoint       = local.cluster_endpoint
  cluster_ca_certificate = local.cluster_ca_certificate
}

# module "jenkins" {
#   source                 = "../jenkins"
#   cluster_endpoint       = local.cluster_endpoint
#   cluster_ca_certificate = local.cluster_ca_certificate
# }

module "monitoring" {
  source                 = "../monitoring"
  cluster_endpoint       = local.cluster_endpoint
  cluster_ca_certificate = local.cluster_ca_certificate
}
