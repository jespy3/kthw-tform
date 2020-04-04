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


# Worker Nodes
variable "worker_node_count" {
  type = number
  description = "Number of worker nodes."
  default = 3
}


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