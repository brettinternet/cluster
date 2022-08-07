# Setup

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

[Install Renovate Bot](https://github.com/apps/renovate) and add to your repository.

[View Renovate bot activity](https://app.renovatebot.com/dashboard).
