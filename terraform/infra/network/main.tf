resource "google_compute_network" "gke_vpc" {
  name                    = "gke-custom-vpc"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "frontend_subnet" {
  name                     = "frontend-subnet"
  ip_cidr_range            = "10.10.1.0/24"
  region                   = var.region
  network                  = google_compute_network.gke_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "backend_subnet" {
  name                     = "backend-subnet"
  ip_cidr_range            = "10.10.2.0/24"
  region                   = var.region
  network                  = google_compute_network.gke_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "argocd_subnet" {
  name                     = "argocd-subnet"
  ip_cidr_range            = "10.10.3.0/24"
  region                   = var.region
  network                  = google_compute_network.gke_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "monitoring_subnet" {
  name                     = "monitoring-subnet"
  ip_cidr_range            = "10.10.4.0/24"
  region                   = var.region
  network                  = google_compute_network.gke_vpc.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_frontend_to_backend" {
  name    = "allow-frontend-to-backend"
  network = google_compute_network.gke_vpc.name

  source_ranges      = [google_compute_subnetwork.frontend_subnet.ip_cidr_range]
  destination_ranges = [google_compute_subnetwork.backend_subnet.ip_cidr_range]

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "3000"]
  }
}

resource "google_compute_firewall" "allow_external" {
  name    = "allow-external"
  network = google_compute_network.gke_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0/0"]
}
