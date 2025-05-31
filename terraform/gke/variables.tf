variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "zone" {
  type        = string
  description = "GCP zone"
}

variable "cluster_name" {
  type        = string
  description = "GKE cluster name"
}

variable "node_count" {
  default = 1
}

variable "machine_type" {
  default = "e2-medium"
}
