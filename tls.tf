# ---------------------------------------------------------------------------------------------------------------------
#  CREATE A CA CERTIFICATE
# ---------------------------------------------------------------------------------------------------------------------


resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits = "2408"
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
    organizational_unit = "CA"
    province = "Oregon"
  }

  # Store the CA public key in a file.
  provisioner "local-exec" {
    command = "echo '${tls_self_signed_cert.ca.cert_pem}' > '${var.ca_public_key_file_path}' && chmod 0600 '${var.ca_public_key_file_path}'"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A TLS CERTIFICATE SIGNED USING THE CA CERTIFICATE
# ---------------------------------------------------------------------------------------------------------------------

