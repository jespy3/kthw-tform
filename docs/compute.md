# Compute Instances

The compute instances are created with Ubuntu servers (v18.04) because they have good support for the `containerd` container runtime. Each instance will have a fixed private IP address simplify the Kubernetes setup process.

## Kubernetes Controllers

Three compute instances are created to **host the Kubernetes control plane**.

Specs:
- `can_ip_forward` - To allow the sending/receiving of packets even if the destination/source IPs don't match.
- _The machine_ - An `n1-standard-1` instance type with a new disk mounted upon booting (`boot_disk`) of size `200GB` based on the image family `ubuntu-1804` from the image project `ubuntu-os-cloud`.
- _Permissions_ - Attached with a `service_account` with the permissions for the following `scopes`:
    - compute-rw
    - storage-ro
    - service-management
    - service-control
    - logging-write
    - monitoring
- _IP Addresses_ - `network_ip` is empty for under the subnetwork to indicate that the IP addresses are dynamically assigned until termination (instead of static/always existing).