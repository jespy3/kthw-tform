// Controllers
resource "google_compute_instance" "controller" {
  count = 3

  name        = "controller-${count.index}"
  description = "Instances for the controllers that host the Kubes control plane."
  zone        = var.gcp_zone

  can_ip_forward = true

  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      size  = 200
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  service_account {
    scopes = [
      "compute-rw",
      "storage-ro",
      "service-management",
      "service-control",
      "logging-write",
      "monitoring",
    ]
  }

  network_interface {
    subnetwork = google_compute_subnetwork.kubernetes.self_link
    network_ip = ""
  }

  tags = [
    var.kthw,
    "controller",
  ]
}