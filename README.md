# kthw-tform
This repo contains the Terraform that sets up Kubernetes using Google Cloud Platform (GCP) based on the [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/) course.

## Get Started

1. Log in to the GCP console and navigate to `IAM & Admin > Service Accounts`.
1. Save the json file for the key of the terraform service account/
1. In the terminal, run `export GOOGLE_CLOUD_KEYFILE_JSON=<path>` where `<path>` is the location of your key's json file.
1. Navigate to the `/infra` directory of the project.
1. Run `terraform plan`.
1. Run `terraform apply`.

## Documentation

- [The Network](/docs/network.md)
- [The Compute Instances](/docs/compute.md)
- [Provisioning a CA and Generating TLS Certificates](/docs/ca-and-tls.md)
- [Generating Kubernetes Configuration Files for Authentication](/docs/kubes-configuration-files.md)
- [Generating the Data Encryption Config and Key](data-encryption.md)

## Workflow

### Starting a session
1. `terraform init`

### Each change
1. Make changes to terraform.
1. `terraform plan`
1. `terraform apply`
1. See changes in GCP console.
1. `terraform fmt`
1. Update documentation as necessary.
1. Commit changes to master.

### Finishing a session
1. `terraform destroy`

## References

- [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/)
- [Getting started with GCP Terraform](https://www.terraform.io/docs/providers/google/guides/getting_started.html)
- [GCP Terraform provider documentation](https://www.terraform.io/docs/providers/google/index.html)