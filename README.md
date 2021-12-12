# Local Docker Vault and Consul Cluster

These are some scripts to run Hashicorp Vault and a cluster of Consul servers, for local development. Think of this an an extension of Vault dev mode, with a full storage cluster.

I created this to support my learning and preparation for the Hashicorp Vault certifications and general local testing.

I also have a nice wrapper around a single instance of Vault dev mode for local testing.

## Features

TODO:
exposure on localhost for easy dns (windows users YMMV)
UI
Traefik
auto unseal
make wrapper
configurable cluster sizes
optional local container builds
totally stateless, by design

## Requirements

* Docker
* Docker-compose
* Make (optional)

## Quick Start (Dev Mode)
#TODO: change command to dev

* `make start-dev` OR `./scripts/start-dev.sh` to start the vault container in dev mode and push it to the background.
* `make stop-dev` OR `./scripts/stop-dev.sh` to kill any container called `dev-vault`

## Future

* auto create a non root user on startup
* Bring additional vault servers into the cluster
* Create demo app (maybe python) to pull limited lifetime database passwords
* Create a cluster using raft backend instead of Consul
* Demo Vault agent: https://gitlab.com/kawsark/vault-agent-docker
* Investigate docker swarm to see if it gets round the dns resolution issues in compose
* Container healthchecks: Might be overkill and cause visual clutter. https://www.consul.io/api-docs/health https://www.consul.io/docs/discovery/checks
* lint and format json and other types
* Move the auto unseal code to something nicer, like python
* SSL everywhere

## Current Limitations

* Vault to Consul traffic is only sent to a single instance due to docker/compose DNS limitations
* Currently everything is running un-encrypted
* only expects one unseal key

## TODO
Centralized place to load versions
enable licenses

## Credits
* https://github.com/testdrivenio/vault-consul-docker
* https://github.com/samrocketman/docker-compose-ha-consul-vault-ui
* consul "The 'ui' field is deprecated. Use the 'ui_config.enabled' field instead."
* nginx lb (deprecated): https://pspdfkit.com/blog/2018/how-to-use-docker-compose-to-run-multiple-instances-of-a-service-in-development/
* hide clusters behind a network, only expose lb https://levelup.gitconnected.com/load-balance-and-scale-node-js-containers-with-nginx-and-docker-swarm-9fc97c3cff81
* review consul config. change datacenter, data dir, ui syntax...
* make ip and test scripts env agnostic. let make call when with a container name
* read container versions from a central location
* turn on UIs
* todo: add dedicated traefik entrypoints for services
* todo traefik dashboard https
* vault operator init -key-shares=6 -key-threshold=3
 * vault audit back end https://www.bogotobogo.com/DevOps/Docker/Docker-Vault-Consul.php

TODO tomorrow
auto unseal container
centralise container versions
go over todo list above