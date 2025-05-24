variable "namespace" {
  default = "monitoring"
}

variable "prometheus_chart_version" {
  default = "58.6.2"
}

variable "cluster_endpoint" {}
variable "cluster_ca_certificate" {}
