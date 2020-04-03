# kthw-tform
This repo contains the Terraform that sets up Kubernetes using Google Cloud Platform (GCP) based on the [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/) course.

## Get Started

1. Log in to the GCP console and navigate to `IAM & Admin > Service Accounts`.
1. Save the json file for the key of the terraform service account/
1. In the terminal, run `export GOOGLE_CLOUD_KEYFILE_JSON=<path>` where `<path>` is the location of your key's json file.
1. Navigate to the root of the project.
1. Run `terraform plan`.
1. Run `terraform apply`.

## Workflow

1. Make changes to terraform.
1. `terraform init`
1. `terraform plan`
1. `terraform apply`
1. See changes in GCP console.
1. `terraform fmt`
1. Update documentation as necessary.
1. Commit changes to master.

## References

- [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/)
- [Getting started with GCP Terraform](https://www.terraform.io/docs/providers/google/guides/getting_started.html)
- [GCP Terraform provider documentation](https://www.terraform.io/docs/providers/google/index.html)