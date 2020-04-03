resource "google_compute_network" "vpc_network" {
  name = "kubernetes-the-hard-way"
  description = "A dedicated custom VPC to host a kubernetes cluster"
  auto_create_subnetworks = false
}