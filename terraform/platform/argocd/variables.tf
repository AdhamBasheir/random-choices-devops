variable "namespace" {
  default = "argocd"
}

variable "argocd_version" {
  default = "8.0.0"
}

variable "cluster_endpoint" {}
variable "cluster_ca_certificate" {}
