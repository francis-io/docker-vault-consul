help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.PHONY:start
start-dev: ##
	@bash bin/start-dev.sh || true # dirty way to supress error if container does not exist

.PHONY: stop
stop-dev:
	@bash bin/stop-dev.sh || true # dirty way to supress error if container does not exist


