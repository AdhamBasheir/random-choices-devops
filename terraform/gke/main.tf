resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location

  network    = "default"
  subnetwork = "default"

  # Create a minimal default node pool to meet GKE requirements, then delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {}
}

resource "google_container_node_pool" "default" {
  name       = "default-node-pool"
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
