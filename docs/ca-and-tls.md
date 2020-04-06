# Provisioning a CA and Generating TLS Certificates

We have created a PKI using CloudFlare's `cfssl`. Using it to create CAs and generate TLS certificates (certs) for the kubes components: `etcd`, `kube-apiserver`, `kube-controller-manager`, `kube-scheduler`, `kubelet`, and `kube-proxy`.

## Certificate Authority (CA)

We created a CA to create new TLS certs. This was done by generating a:
- CA configuration file (`ca-config.json` + `ca-csr.json` to create a CA request `ca.csr`)
- certificate (`ca.pem`)
- private key (`ca-key.pem`)

## Client and Server Certificates

We created client and server certs for each Kubernetes component PLUS a client cert for the Kubes `admin` user.

The following files are created for each `Admin Client`, `Worker node`, `Kube Controller`, `Kube Proxy`, `Kube Scheduler`, `Kubes API Server`, and `Service Account`:
- Private key (`{component}-key.pem`)
- Certificate (`{component}.pem`)

Kubernetes has a mode called **Node Authorizer** to authorise Kubes API calls made by Kubelets. Therefore, the worker nodes must use a credential that identifies them being in the `system:nodes` group. This is why each worker cert above is created to meet the Node Authorizer's requirements.

For the **Kubes API Server** cert, the KTHW static IP address is included as an alternative name to ensure the cert can be validated by remote clients.

The services in the **Control Plane** have the subnet IP range `10.32.0.0/24` reserved for them. The first IP address `10.20.0.1` is linked with the `kubernetes` internal DNS name which is assigned to the _Kubes API Server_'s cert.

The **Kubes Controller Manager** uses a key pair to create **Service Account** tokens.

## Copying these certs to the Kubes nodes

The certs and private keys are added to each Kubes instance/node using:
```
  gcloud compute scp <file> <file> <instance-name>:<location>
```

- **Worker instances** - The CA cert, and worker node cert and private key files are all copied to the home directory of these worker instances (`~/`).
- **Controller instances** - - The CA cert and private key, Kubes API Server cert and private key, and the Service Account cert and private key files are all copied to the home directory of these controller instances (`~/`).

_Validation:_
SSHing into an instance and checking if the file is listed at `~/`
```
  gcloud compute ssh <instance-name>

  cd ~/
  ls
```

## Glossary

- **PKI** - Public Key Infrastructure. An artchitecture that associates public keys with people/organisations by a CA (Certificate Authority).
- **CA** - Certificate Authority. An entity that issues digital certificates which ensures the ownership of a public key by the entity that owns the certificate.
- **CloudFlare** - A web infrastructure and security company.
- **cfssl** - CloudFlare's tool to sign, verify and bundle TLS certificates.
- **TLS** - Transport Layer Security. The newer version of SSL (Secure Sockets LAyer), both are cryptographic protocols to authenticate data transfer between things on the internet.

### What's Next?
- [Kubeconfig files](/docs/kubes-configuration-files.md)

## References

-[How TLS/SSL works](https://github.com/gruntwork-io/private-tls-cert)