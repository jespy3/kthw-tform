# Generating Kubernetes Configuration Files for Authentication

Kubes configuration files (known as **kubeconfigs**) are created to locate and authenticate to the Kubes API servers.

## Kubernetes Public IP Address

The IP assigned to the external load balancers in front of the Kubes API server is needed as each kubeconfig requires a connection to it.

Retrieving the public IP address:
```
  gcloud compute addresses list
  gcloud config get-value compute/region

  gcloud compute addresess describe kubernetes-the-hard-way \
    --region $(gcloud config get-value compute/region) \
    --filter 'value(address)'

  KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
    --region $(gcloud config get-value compute/region) \
    --format 'value(address)'
  )
```

_Validation:_
```
  echo $KUBERNETES_PUBLIC_ADDRESS
```

## Kubeconfig file creation

For the `kube-proxy`, `kubelet` (worker nodes), `kube-scheduler`, `kube-controller-manager` clients and the `admin` user, we constructed the three sections of a `kubeconfig` file with:

**For Clusters**:
```
  kubectl config set-cluster kubernetes-the-hard-way \
    --kubeconfig=<component>.kubeconfig \
    --certificate-authority=ca.pem \
    --server=https://$KUBERNETES_PUBLIC_ADDRESS:6443
    --embed-certs=true
```

**For Users**
```
  kubectl config set-credentials <component-username> \
    --kubeconfig=<component>.kubeconfig \
    --client-certificate=<component>.pem \
    --client-key=<component>-key.pem \
    --embed-certs=true
```

Where:
- `<component-username>` = `system:node:<kubelet>`, `system:<component>` for clients and `admin` for the admin user.

**For Contexts**:
```
  kubectl config set-context default \
    --kubeconfig=<component>.kubeconfig \
    --cluster=kubernetes-the-hard-way \
    --user=<component-username>
```

Then finally, the following is run to use the created context in the kubeconfig file:
```
  kubectl config use-context default --kubeconfig=<component>.kubeconfig
```

_Validation:_
The following files have been created (you can `cat <component>.kubeconfig` these):
```
  worker-{i}.kubeconfig
  kube-proxy.kubeconfig
  kube-controller-manager.kubeconfig
  kube-scheduler.kubeconfig
  admin.kubeconfig
```

## Copying these kubeconfigs to the Kubes nodes

The `kubeconfig` files are added to each Kubes instance/node using:
```
  gcloud compute scp <file> <file> <instance-name>:<location>
```

- **Worker instances** - The kubeconfigs for the kubelet (`worker-{i}.kubeconfig`) and the `kube-proxy` are all copied to the home directory of these worker instances (`~/`).
- **Controller instances** - - The kubeconfigs for the `kube-controller-manager`, `kube-scheduler`, and `admin` are all copied to the home directory of these controller instances (`~/`).

_Validation:_
SSHing into an instance and checking if the file is listed at `~/`
```
  gcloud compute ssh <instance-name>

  cd ~/
  ls
```