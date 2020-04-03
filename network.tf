// VPC
resource "google_compute_network" "kubernetes_the_hard_way" {
  name = "kubernetes-the-hard-way"
  description = "A dedicated custom VPC to host a kubernetes cluster."
  auto_create_subnetworks = false
}

// Subnet
resource "google_compute_subnetwork" "kubernetes" {
  name          = "kubernetes"
  description   = "A group of IPs within the VPC for the kubernetes cluster."
  ip_cidr_range = "10.240.0.0/24"
  network       = google_compute_network.kubernetes_the_hard_way.self_link
}
