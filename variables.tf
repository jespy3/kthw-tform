variable "kthw" {
  type        = string
  description = "Abbreviation for the course name."
  default     = "kubernetes-the-hard-way"
}

variable "gcp_region" {
  type = string
  description = "Default region for the GCP project."
  default = "us-west1"
}

variable "gcp_zone" {
  type = string
  description = "Default zone for the GCP project."
  default = "us-west1-c"
}

variable "gcp_project" {
  type = string
  description = "The GCP project name."
  default = "solid-linker-238123"
}