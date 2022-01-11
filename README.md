# Local Docker Vault and Consul Cluster

These are some scripts to run Hashicorp Vault and a cluster of Consul servers, for local development. Think of this an an extension of Vault dev mode, with a full storage cluster.

I created this to support my learning and preparation for the Hashicorp Vault certifications and general local testing.

I also have a nice wrapper around a single instance of Vault dev mode for local testing.

## Features

* Service exposure on a domain for easy DNS using Traefik (Windows users YMMV)
* Dashboards activated on Vault and Consul
* (Super insecure) Auto unseal for easy development
* Configurable cluster sizes. Currently supports scaling consul from a single Consul node to how ever many you like
* Read and load Vault policies from a directory (see `./vault/policies/`)
* optional local container builds if you want to modify either Vault or Consul beyond mounting config (currently, just uncomment in the `docker-compose.yaml`)
* Totally stateless (by design). You will always get a fresh environment
* Control the version of Consul and Vault from the .env file

## Requirements

* Docker
* Docker-compose
* Make (optional)

## Quick Start

* `make start` or `./scripts/start.sh` to start the cluster.
* `make stop` or `./scripts/stop.sh` to stop the cluster.

* You can scale up the (currently only Consul) cluster beyond the default 3 with something like `make start count=7` or `./scripts/start.sh 7`

## Specific Mac instructions
```
brew install docker --cask
brew install docker-compose make
(start docker service)
make start
```

### Dev mode

* `make start-dev` OR `./scripts/start-dev.sh` to start the vault container in dev mode and push it to the background.
* `make stop-dev` OR `./scripts/stop-dev.sh` to kill any container called `dev-vault`

## Current Limitations

* Vault to Consul traffic is only sent to a single instance due to docker/compose DNS limitations. Swarm might be a solution to this.
* Currently everything is running un-encrypted
* Assumes one unseal key

## Future Tasks

* Auto create a non root user on startup
* Bring additional vault servers into the cluster
* Create demo app (maybe python) to pull limited lifetime database passwords
* Create a cluster using raft backend instead of Consul
* Demo Vault agent
* Investigate docker swarm to see if it gets round the dns resolution issues in compose
* lint and format json and other types
* Move the auto unseal code to something nicer, like python
* SSL everywhere
* Enable licenses to test Enterprise features
* Hide nodes in a virtual network, so you can only hit the proxy
* Move Consul config to HCL
* Enable Audit backends

## Credits and Inspiration
* https://github.com/testdrivenio/vault-consul-docker
* https://github.com/samrocketman/docker-compose-ha-consul-vault-ui
* nginx lb (deprecated): https://pspdfkit.com/blog/2018/how-to-use-docker-compose-to-run-multiple-instances-of-a-service-in-development/
