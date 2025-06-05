locals {
  project_id             = data.terraform_remote_state.infra.outputs.general_info.project_id
  region                 = data.terraform_remote_state.infra.outputs.general_info.region
  zone                   = data.terraform_remote_state.infra.outputs.general_info.zone
  cluster_name           = data.terraform_remote_state.infra.outputs.gke_info.cluster_name
  cluster_endpoint       = data.terraform_remote_state.infra.outputs.gke_info.cluster_endpoint
  cluster_ca_certificate = data.terraform_remote_state.infra.outputs.gke_info.cluster_ca_certificate
}
