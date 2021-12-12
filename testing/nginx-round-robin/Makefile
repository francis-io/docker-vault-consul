help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

start:
	docker-compose up --build --detach --remove-orphans --scale echo-container5000=$(count) --scale echo-container5001=$(count)

	@bash scripts/print_ip.sh

test:
	@bash scripts/test.sh

stop:
	docker-compose down -v --rmi all --remove-orphans

clean:
	docker system prune --all --force