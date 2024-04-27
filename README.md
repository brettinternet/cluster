# K8s Cluster

[![Lint](https://github.com/brettinternet/cluster/actions/workflows/lint.yaml/badge.svg)](https://github.com/brettinternet/cluster/actions/workflows/lint.yaml)

## Features

- Lots of [self-hosted services](./kubernetes/apps)
- [Flux](https://toolkit.fluxcd.io/) GitOps with this repository ([kubernetes directory](./kubernetes))
- Ansible node provisioning and [K3s setup](https://github.com/PyratLabs/ansible-role-k3s) (Ansible [roles](./provision/ansible/roles) and [playbooks](./provision/ansible))
- Terraform DNS records ([terraform](./provision/terraform))
- [SOPS](https://github.com/mozilla/sops) secrets stored in Git
- [Renovate bot](https://github.com/renovatebot/renovate) dependency updates
- WireGuard VPN pod gateway via paid service
- WireGuard VPN proxy hosted on VPS
- [Cloudflared HTTP tunnel](https://github.com/cloudflare/cloudflared)
- [K8s gateway](https://github.com/ori-edge/k8s_gateway) for local DNS resolution to the cluster and [NGINX ingress controller](https://kubernetes.github.io/ingress-nginx/)
- Both internal & external services with a service [gateway](https://github.com/ori-edge/k8s_gateway/)
- OIDC [authentication](https://www.authelia.com/configuration/identity-providers/open-id-connect/) with [LDAP](https://github.com/nitnelave/lldap)
- Automatic Cloudflare DNS updates ([ddns cronjob](./kubernetes/apps/networking/cloudflare-ddns))
- [Cilium](https://cilium.io/) container networking interface (CNI) and [layer 4 loadbalancing](https://cilium.io/use-cases/load-balancer/)
- [ZFS](https://wiki.archlinux.org/index.php/ZFS)
- JBOD [mergerfs](https://github.com/trapexit/mergerfs) union NFS with [SnapRAID](https://www.snapraid.it) backup for low-touch media files ([snapraid-runner kubernetes cronjob](./kubernetes/apps/media/snapraid-runner))
- [Restic](https://restic.net) backups to remote and local buckets ([backup namespace](./kubernetes/apps/backup))
- [go-task](https://taskfile.dev) shorthand for useful commands ([Taskfile](./Taskfile.yaml) and [taskfiles](./.taskfiles))

## Usage

Setup and usage is inspired heavily by [this homelab gitops template](https://github.com/onedr0p/flux-cluster-template) and the [k8s-at-home](https://github.com/k8s-at-home) community. You can find similar setups with the [k8s at home search](https://nanne.dev/k8s-at-home-search/). Historical revisions of this repository had rootless Podman containers deployed with ansible as systemd units, and a single-node docker compose orchestration before that.

Looking for a simpler devops experience? Checkout my docker deployment at [brettinternet/homelab](https://github.com/brettinternet/homelab).

### Setup

[Install go-task](https://taskfile.dev/installation/)

Install dependencies and setup environment:

```sh
task init
```

Then, provision your infrastructure:

```sh
task ansible:{init,list,ping,setup,install,status}
```

Setup a Cloudflare Tunnel.

```sh
task terraform:{init,tunnel-plan,tunnel-apply}
```

Add tunnel information to cluster settings.

### Deploy

#### Kubernetes

Verify flux can be installed. Then, push changes to remote repo and install.

```sh
task flux:{verify,install}
```

Push latest to repo - you can use the [wip.sh](./scripts/wip.sh) script for that with `task wip`.

```sh
task flux:reconcile
```

```sh
task kubernetes:resources
```

Most deployments in this repo use an `app-template` chart with [these configuration options](https://github.com/bjw-s/helm-charts/tree/main/charts/library/common).
