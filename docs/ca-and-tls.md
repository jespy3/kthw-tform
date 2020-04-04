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

## Glossary

**PKI** - Public Key Infrastructure. An artchitecture that associates public keys with people/organisations by a CA (Certificate Authority).
**CA** - Certificate Authority. An entity that issues digital certificates which ensures the ownership of a public key by the entity that owns the certificate.
**CloudFlare** - A web infrastructure and security company.
**cfssl** - CloudFlare's tool to sign, verify and bundle TLS certificates.
**TLS** - Transport Layer Security. The newer version of SSL (Secure Sockets LAyer), both are cryptographic protocols to authenticate data transfer between things on the internet.