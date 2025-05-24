variable "namespace" {
  default = "monitoring"
}

variable "prometheus_chart_version" {
  default = "59.0.0"
}

variable "cluster_endpoint" {}
variable "cluster_ca_certificate" {}
