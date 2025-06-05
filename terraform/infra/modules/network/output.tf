output "network" {
  value = google_compute_network.gke_vpc.id
}

output "subnet" {
  value = google_compute_subnetwork.gke_subnet.id
}
