# Controllers
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
    network_ip = "10.240.0.1${count.index}"
    access_config {
      nat_ip = ""
    }
  }


  tags = [
    var.kthw,
    "controller",
  ]
}

# Workers
resource "google_compute_instance" "worker" {
  count = 2

  name        = "worker-${count.index}"
  description = "Instances for the Kubes worker nodes."
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
    network_ip = "10.240.0.2${count.index}"
    access_config {
      nat_ip = ""
    }
  }


  metadata = {
    pod-cidr = "10.200.${count.index}.0/24"
  }

  tags = [
    var.kthw,
    "worker",
  ]
}