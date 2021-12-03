# Local Vault Docker Lab

These are some quick and dirty helper scripts to run Hashicorp Vault in dev mode for local testing. Nothing is persisted between container restarts.

## Requirements

* Docker
* Make (optional)

## Quick Start
* `make start` OR `./start.sh` to start the vault container in dev mode and push it to the background.
* `make stop` OR `./stop.sh` to kill any container called `dev-vault`

## Future

I might extend this to a full HA consul setup in the future.

[This](https://github.com/samrocketman/docker-compose-ha-consul-vault-ui) might be a good starting point. I want to rip out any local persistance, I think.
