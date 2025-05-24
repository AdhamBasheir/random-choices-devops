variable "zone" {
  type        = string
  description = "GCP zone"
}

variable "location" {
    type        = string
    description = "GCP location"
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "cluster_name" {
  type        = string
  description = "GKE cluster name"
}

variable "node_count" {
  default = 2
}

variable "machine_type" {
  default = "e2-medium"
}