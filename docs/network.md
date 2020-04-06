# Network

## VPC / Network

```
  gcloud compute networks list
```

### Subnet

```
  gcloud compute networks subnets list
```

### Firewalls

Two firewalls are set up. One to allow access from within the kubernetes-the-hard-way (kthw) network, and the other to allow access to kthw network from external sources.

```
  gcloud compute firewall-rules list
```

### Public IP Address

There is a static IP address that will be attached to the external load balancer in front of the Kubernetes API servers.

**Command Line:**
```
  gcloud compute addresses list
```

**Console:** `VPC Network > External IP addresses`


### What's Next?
- [Compute Instances](/docs/compute.md)