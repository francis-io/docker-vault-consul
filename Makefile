help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.PHONY: start
start: ## Start a Vault instance with a Consul cluster behind. Defaults to a 3 node Consul cluster.
ifdef count
	@bash scripts/start.sh $(count)
else
	@bash scripts/start.sh
endif

.PHONY: stop
stop: ## Stop the cluster.
	@bash scripts/stop.sh

.PHONY:start-dev
start-dev: ## Start Vault in dev mode. Uses local storage.
	@bash scripts/start-dev.sh

.PHONY: stop-dev
stop-dev: ## Stop the Vault dev cluster, if exists.
	@bash scripts/stop-dev.sh

clean:
	docker system prune --all --force
