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
