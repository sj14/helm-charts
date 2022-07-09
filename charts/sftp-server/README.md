# sftp-server

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for https://github.com/atmoz/sftp

## Source Code

* <https://github.com/sj14/helm-charts>

## Installation

```console
helm repo add sj14 https://sj14.github.io/helm-charts
helm upgrade sftp --install sj14/sftp-server
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| extraContainers | list | `[]` | Additional containers of the pod. |
| extraInitContainers | list | `[]` | Additional Init containers of the pod. |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/atmoz/sftp/alpine@sha256"` |  |
| image.tag | string | `"688d93138e4d8c1b6401c9d8be5ec4b6153bdce4a7322ce4d7349ba75b6845f8"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistentVolume.accessModes | list | `["ReadWriteOnce"]` | Must match those of existing PV or dynamic provisioner Ref: http://kubernetes.io/docs/user-guide/persistent-volumes/ |
| persistentVolume.annotations | object | `{}` |  |
| persistentVolume.enabled | bool | `false` |  |
| persistentVolume.existingClaim | string | `""` | If defined, PVC must be created manually before volume will be bound |
| persistentVolume.size | string | `"8Gi"` |  |
| persistentVolume.storageClass | string | `nil` | If defined, storageClassName: <storageClass> If set to "-", storageClassName: "", which disables dynamic provisioning If undefined (the default) or set to null, no storageClassName spec is   set, choosing the default provisioner.  (gp2 on AWS, standard on   GKE, AWS & OpenStack)  |
| persistentVolume.subPath | string | `""` | Subdirectory of SFTP server data Persistent Volume to mount Useful if the volume's root directory is not empty  |
| persistentVolume.volumeBindingMode | string | `nil` | If defined, volumeBindingMode: <volumeBindingMode> If undefined (the default) or set to null, no volumeBindingMode spec is   set, choosing the default mode.  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `22` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| sftp.hostKeys.ed25519 | string | `""` | private ED25519 host key |
| sftp.hostKeys.rsa | string | `""` | private RSA host key |
| sftp.users[0].dirs[0] | string | `"upload"` |  |
| sftp.users[0].guid | string | `""` |  |
| sftp.users[0].name | string | `"demo"` |  |
| sftp.users[0].pass | string | `"demo"` |  |
| sftp.users[0].passEncrypted | bool | `false` | password is encrypted ([doc](https://github.com/atmoz/sftp/blob/ffeb104beec76cc622abda34ee2132c790b5559c/README.md#encrypted-password)) |
| sftp.users[0].pubKeys | list | `[]` | public user keys ([doc](https://github.com/atmoz/sftp/blob/ffeb104beec76cc622abda34ee2132c790b5559c/README.md#logging-in-with-ssh-keys)) |
| sftp.users[0].uid | string | `""` |  |
| tolerations | list | `[]` |  |
