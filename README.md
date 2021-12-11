# Local Vault Docker Lab

These are some quick and dirty helper scripts to run Hashicorp Vault in dev mode for local testing. Nothing is persisted between container restarts.

## Requirements

* Docker
* Docker-compose
* Make (optional)

## Quick Start

* `make start` OR `./start.sh` to start the vault container in dev mode and push it to the background.
* `make stop` OR `./stop.sh` to kill any container called `dev-vault`

## Future

I might extend this to a full HA consul setup in the future.

[This](https://github.com/samrocketman/docker-compose-ha-consul-vault-ui) might be a good starting point. I want to rip out any local persistance, I think.
https://github.com/testdrivenio/vault-consul-docker

create demo app to pull creds?

Create a cluster using raft backend

https://gitlab.com/kawsark/vault-agent-docker: docker vault agent example

* lint and format json and other types

## Cheatsheet
consul memebers
consul operator raft list-peers
test hitting different consul servers: https://learn.hashicorp.com/tutorials/consul/load-balancing-envoy?in=consul/developer-mesh#default-load-balancing-policy

## TODO
Centralised place to load versions
Can i use --scale? https://docs.docker.com/compose/reference/up/
healthchecks: https://www.consul.io/api-docs/health https://www.consul.io/docs/discovery/checks
## Credits
* https://github.com/testdrivenio/vault-consul-docker
* https://github.com/samrocketman/docker-compose-ha-consul-vault-ui
* consul "The 'ui' field is deprecated. Use the 'ui_config.enabled' field instead."
* nginx lb: https://pspdfkit.com/blog/2018/how-to-use-docker-compose-to-run-multiple-instances-of-a-service-in-development/
* add actual clusters in a network, only expose lb https://levelup.gitconnected.com/load-balance-and-scale-node-js-containers-with-nginx-and-docker-swarm-9fc97c3cff81
* traefik might be a better lb https://stackoverflow.com/a/54388725
* SSL?
* lint nginx file
* review consul config. change datacentre, data dir...
* https://pspdfkit.com/blog/2018/how-to-use-docker-compose-to-run-multiple-instances-of-a-service-in-development/
* make ip and test scripts env agnostic. let make call when with a container name
* read container versions from a central location
* turn on UIs
