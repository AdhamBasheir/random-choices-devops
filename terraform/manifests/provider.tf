provider "google" {
  project = data.terraform_remote_state.infra.outputs.general_info.project_id
  region  = data.terraform_remote_state.infra.outputs.general_info.region
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.infra.outputs.gke_info.cluster_endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.infra.outputs.gke_info.cluster_ca_certificate)
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.36.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30.0"
    }
  }
}
