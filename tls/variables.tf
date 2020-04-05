# CAs and TLS
variable "certs_directory_path" {
  type        = string
  description = "Path to the CAs public key file."
  default     = "./.certs"
}

variable "private_key_algorithm" {
  type        = string
  description = "The algorithm used for generating a private key."
  default    = "RSA"
}

variable "private_key_rsa_bits" {
  type        = string
  description = "The size of the generated RSA key in bits."
  default    = "2048"
}

variable "permissions" {
   type = string
   description = "The Unix file permission to assign to the cert files (e.g. 0600)."
   default = "0600"
}