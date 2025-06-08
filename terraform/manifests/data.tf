data "google_client_config" "default" {}

data "terraform_remote_state" "infra" {
  backend = "remote"

  config = {
    organization = "AdhamBasheir"
    workspaces = {
      name = "infra"
    }
  }
}

data "terraform_remote_state" "platform" {
  backend = "remote"

  config = {
    organization = "AdhamBasheir"
    workspaces = {
      name = "platform"
    }
  }
}

data "local_file" "app_of_apps" {
  filename = "${path.module}/argocd.yaml"
}

data "local_file" "cert" {
  filename = "${path.module}/cert.yaml"
}
