variable "kthw" {
  type        = string
  description = "Abbreviation for the course name."
  default     = "kubernetes-the-hard-way"
}

variable "gcp_region" {
  type        = string
  description = "Default region for the GCP project."
  default     = "us-west1"
}

variable "gcp_zone" {
  type        = string
  description = "Default zone for the GCP project."
  default     = "us-west1-c"
}

variable "gcp_project" {
  type        = string
  description = "The GCP project name."
  default     = "solid-linker-238123"
}

variable "ca_public_key_file_path" {
  type        = string
  description = "Path to the CAs public key file."
  default     = "./.certs/ca.pem"
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