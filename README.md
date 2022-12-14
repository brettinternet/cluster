# K8s Cluster

## Features

- Rancher's K3s
- Flux
- Ansible node provisioning
- Terraform DNS updates
- SOPS
- Renovate bot dependency updates

## Deployments

Most deployments in this repo use an `app-template` chart with [these configuration options](https://github.com/bjw-s/helm-charts/tree/main/charts/library/common).

## Setup

[Install go-task](https://taskfile.dev/installation/)

```sh
task init
```

Setup env vars in `.env`.

```sh
task verify

task configure
```

Then, provision your infrastructure.

```sh
task ansible:init

task ansible:list

task ansible:setup

task ansible:install

# Last install step which ensures k3s.service status sometimes fails,
# use this to verify each k3s service is 'active' (instead of 'activating')
task ansible:status
task cluster:nodes
```

Setup DNS.

```sh
task terraform:init

task terraform:plan

task terraform:apply
```

Verify flux can be installed.

```sh
task cluster:verify
```

Push changes to remote repo.

```sh
task cluster:install

task cluster:resources
```

## Renovate

[Install Renovate Bot](https://github.com/apps/renovate), add to your repository and [view Renovate bot activity](https://app.renovatebot.com/dashboard), or use the self-hosted option.
