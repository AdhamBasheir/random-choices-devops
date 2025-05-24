resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location
  
  network    = "default"
  subnetwork = "default"

  # Create a minimal default node pool to meet GKE requirements, then delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {}
  
  node_config {
    service_account = google_service_account.gke_service_account.email
  }

  deletion_protection = false  # Add this line to disable deletion protection
}

resource "google_container_node_pool" "default" {
  name       = "default-node-pool"
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    service_account = google_service_account.gke_service_account.email
    tags = ["gke-node-tag"]
  }
}

resource "google_service_account" "gke_service_account" {
  account_id   = "gke-service-account"
  display_name = "GKE Service Account"
}

resource "google_project_iam_member" "service_account_owner" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.gke_service_account.email}"
}

resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https-to-envoy"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction    = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["gke-node-tag"]
  description = "Allow HTTP and HTTPS ingress to Envoy LoadBalancer"
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }

  direction    = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["gke-node-tag"]
  description = "Allow all internal traffic from anywhere"
}