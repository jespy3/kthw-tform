# ---------------------------------------------------------------------------------------------------------------------
#  CREATE A CA CERTIFICATE
# ---------------------------------------------------------------------------------------------------------------------


resource "tls_private_key" "ca" {
  algorithm = var.private_key_algorithm
  rsa_bits = var.private_key_rsa_bits

  # Store the CA's private key in a file.
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ca.private_key_pem}' > '${var.certs_directory_path}/ca-key.pem' && chmod ${var.permissions} '${var.certs_directory_path}/ca-key.pem'"
  }
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm = tls_private_key.ca.algorithm
  private_key_pem = tls_private_key.ca.private_key_pem
  is_ca_certificate = true

  validity_period_hours = 8760
  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]

  subject {
    common_name = "Kubernetes"
    country = "US"
    locality = "Portland"
    organization = "Kubernetes"
    organizational_unit = "CA"
    province = "Oregon"
  }

  # Store the CA public key in a file.
  provisioner "local-exec" {
    command = "echo '${tls_self_signed_cert.ca.cert_pem}' > '${var.certs_directory_path}/ca.pem' && chmod ${var.permissions} '${var.certs_directory_path}/ca.pem'"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A TLS CERTIFICATE SIGNED USING THE CA CERTIFICATE
# ---------------------------------------------------------------------------------------------------------------------

# Admin Client
resource "tls_private_key" "admin" {
  algorithm = var.private_key_algorithm
  rsa_bits = var.private_key_rsa_bits

  # Store the certificate's private key in a file.
  provisioner "local-exec" {
    command = "echo '${tls_private_key.admin.private_key_pem}' > '${var.certs_directory_path}/admin-key.pem' && chmod ${var.permissions} '${var.certs_directory_path}/admin-key.pem'"
  }
}

resource "tls_cert_request" "admin" {
  key_algorithm = tls_private_key.admin.algorithm
  private_key_pem = file("${var.certs_directory_path}/admin-key.pem")

  subject {
    common_name = "admin"
    country = "US"
    locality = "Portland"
    organization = "system:masters"
    organizational_unit = "Kubernetes The Hard Way"
    province = "Oregon"
  }
}

resource "tls_locally_signed_cert" "admin" {
  cert_request_pem = tls_cert_request.admin.cert_request_pem

  ca_key_algorithm = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem = file("${var.certs_directory_path}/ca.pem")

  validity_period_hours = 8760
  allowed_uses = [
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]

  # Store the Admins cert in a file.
  provisioner "local-exec" {
    command = "echo '${tls_locally_signed_cert.admin.cert_pem}' > '${var.certs_directory_path}/admin.pem' && chmod ${var.permissions} '${var.certs_directory_path}/admin.pem'"
  }
}

# Kubelet Clients/Worker Nodes
resource "tls_private_key" "worker" {
  count = var.worker_node_count

  algorithm = var.private_key_algorithm
  rsa_bits = var.private_key_rsa_bits
}

resource "tls_cert_request" "worker" {
  count = var.worker_node_count

  key_algorithm = tls_private_key.worker[count.index].algorithm
  private_key_pem = tls_private_key.worker[count.index].private_key_pem

  dns_names = [
    "worker-${count.index}",
  ]
  ip_addresses = [
    google_compute_instance.worker[count.index].network_interface[0].network_ip,
    google_compute_instance.worker[count.index].network_interface[0].access_config[0].nat_ip,
  ]

  subject {
    common_name = "system:node:worker-${count.index}"
    country = "US"
    locality = "Portland"
    organization = "system:nodes"
    organizational_unit = "Kubernetes The Hard Way"
    province = "Oregon"
  }
}

resource "tls_locally_signed_cert" "worker" {
  count = var.worker_node_count

  cert_request_pem = tls_cert_request.worker[count.index].cert_request_pem

  ca_key_algorithm = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem = file("${var.certs_directory_path}/ca.pem")

  validity_period_hours = 8760
  allowed_uses = [
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]
}