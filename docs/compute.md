# Compute Instances

The compute instances are created with Ubuntu servers (v18.04) because they have good support for the `containerd` container runtime. Each instance will have a fixed private IP address simplify the Kubernetes setup process.

## Kubernetes Controllers

Three compute instances are created to **host the Kubernetes control plane**.

Specs:
- `can_ip_forward` - To allow the sending/receiving of packets even if the destination/source IPs don't match.
- _The machine_ - An `n1-standard-1` instance type with a new disk mounted upon booting (`boot_disk`) of size `200GB` based on the image family `ubuntu-1804` from the image project `ubuntu-os-cloud`.
- _Permissions_ - Attached with a `service_account` with the permissions for the following `scopes`:
    - `compute-rw`
    - `storage-ro`
    - `service-management`
    - `service-control`
    - `logging-write`
    - `monitoring`
- _IP Addresses_ - `network_ip` to define their private IP
- _External IP_ - The `access_config`'s `nat_ip` is defined as blank to automatically assign a public IP for internet access.
- The CA cert and private key, Kubes API Server cert and private key, and the Service Account cert and private key files are all copied to the home directory of these controller instances (`~/`).

**Command Line:**
```
  gcloud compute instances list
```

**Console:** `Compute Engine > VM Instances`

## Kubernetes Workers

Two compute instances to **host the Kubernetes worker nodes**. Each needs a pod subnet allocation from the Kubes cluster CIDR range which is used to give subnet allocations to compute instances at runtime. Here, the cluster's CIDR range is `10.200.0.0/16` which supports 256 subnets.

Specs/Command Line/Console: (Same as the controllers above)
- The CA cert, and worker node cert and private key files are all copied to the home directory of these worker instances (`~/`).

## Configuring SSH Access

Connecting to these compute instances for the first time will generate SSH keys for you and store them in the project metadata.

SSH-ing into the `controller-0` instance
```
  gcloud compute ssh controller-0
```

Entering a passphrase, the your generated SSH keys are stored in your machine @ `/home/$USER/.ssh/google_compute_engine` for your private key and `/home/$USER/.ssh/google_compute_engine.pub` for your public key.

In the `controller-0` instance, your public key is stored as part of the `home/$USER/.ssh/authorized_keys` file. Your machine will provide its public key to the instance to authorise itself.

Run `exit` to exit your SSH session.

### What's Next?
- [Certificate Authorities and TLS](/docs/ca-and-tls.md)