# Generating the Data Encryption Config and Key

We created an _encryption key_ to encrypt our cluster's data at rest and a _encryption configuration_ to encrypt Kubernetes Secrets. This data to be encrypted includes cluster state, application configurations, and secrets.

## Creating the Encryption Key

An encryption key was generated and saved using:
```
  ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
```

## Creating the Encryption Config File and Uploading it

An `encryption-config.yaml` file was created:
```
  kind: EncryptionConfig
  apiVersion: v1
  resources:
    - resources:
        - secrets
      providers:
        - aescbc:
            keys:
              - name: key1
                secret: ${ENCRYPTION_KEY}
        - identity: {}
```

Then copied over to each `controller-{i}` instance using:
```
  gcloud compute scp encryption-config.yaml controller-{i}:~/
```

_Validation:_
SSHing into an instance and checking if the file is listed at `~/`
```
  gcloud compute ssh controller-{i}

  cd ~/
  ls
```

### What's Next?
- [Bootstrapping the etcd cluster](/docs/etcd.md)