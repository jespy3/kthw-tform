// VPC
resource "google_compute_network" "kubernetes_the_hard_way" {
  name                    = "kubernetes-the-hard-way"
  description             = "A dedicated custom VPC to host a kubernetes cluster."
  auto_create_subnetworks = false
}

// Subnet
resource "google_compute_subnetwork" "kubernetes" {
  name          = "kubernetes"
  description   = "A group of IPs within the VPC for the kubernetes cluster."
  ip_cidr_range = "10.240.0.0/24"
  network       = google_compute_network.kubernetes_the_hard_way.self_link
}

// Firewalls - Controls access to and from instances in the VPC
resource "google_compute_firewall" "kubernetes_the_hard_way_allow_internal" {
  name        = "kubernetes-the-hard-way-allow-internal"
  description = "A firewall rule to allow internal communication across all protocols."
  network     = google_compute_network.kubernetes_the_hard_way.self_link

  source_ranges = [
    "10.240.0.0/24",
    "10.200.0.0/16",
  ]

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "kubernetes_the_hard_way_allow_external" {
  name        = "kubernetes-the-hard-way-allow-external"
  description = "A firewall rule to allow communication from outside the VPC using SSH, ICMP, and HTTPS."
  network     = google_compute_network.kubernetes_the_hard_way.self_link

  source_ranges = [
    "0.0.0.0/0",
  ]

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }
  allow {
    protocol = "icmp"
  }
}