# Network

## VPC / Network

GCP commands:
```
  gcloud compute networks list
```

### Subnet

GCP commands:
```
  gcloud compute networks subnets list
```

### Firewalls

Two firewalls are set up. One to allow access from within the kubernetes-the-hard-way (kthw) network, and the other to allow access to kthw network from external sources.

GCP commands:
```
  gcloud compute firewall-rules list
```