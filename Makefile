help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.PHONY:start-dev
start-dev: ##
	@bash bin/start-dev.sh || true # dirty way to supress error if container does not exist

.PHONY: stop-dev
stop-dev:
	@bash bin/stop-dev.sh || true # dirty way to supress error if container does not exist

.PHONY: start
start:
	# defaults to 2 extra consul nodes, giving a 3 node cluster
	docker-compose up --build --detach --remove-orphans --scale consul-workers=$(or $(count), 2)

	@bash print_ip.sh

test:
	#@bash test.sh

stop:
	docker-compose down #-v --rmi all --remove-orphans

clean:
	docker system prune --all --force
