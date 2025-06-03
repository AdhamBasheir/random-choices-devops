terraform {
  backend "remote" {
    organization = "AdhamBasheir"

    workspaces {
      name = "manifests"
    }
  }
}

resource "kubernetes_manifest" "app_of_apps" {
  manifest = yamldecode(data.local_file.app_of_apps.content)
}
