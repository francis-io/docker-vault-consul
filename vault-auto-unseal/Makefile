help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.PHONY: start
start:
	docker-compose up --build --remove-orphans


stop:
	docker-compose down #-v --rmi all --remove-orphans

clean:
	docker system prune --all --force
