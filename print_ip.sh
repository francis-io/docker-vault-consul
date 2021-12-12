#!/usr/bin/env bash

# Make the script exit on error. Add "|| true to override this".
set -o errexit

# Exit when the script tries to use an undeclared variable.
set -o nounset

# Get the exit status of the last thing that failed. Useful when using pipes.
set -o pipefail


log() {
  echo "$(date +'%H:%M:%S'): $*" >&2
}

main() {
    #log "Vault starting..."
    #docker run --rm --cap-add=IPC_LOCK -d --name=dev-vault vault &> /dev/null

    # LB_IP="$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' lb)"

    # #wait_for_url http://${VAULT_ADDR}

    # log "Load balancer IP is: ${IP}. Run $ make test"
    # log "$ curl ${IP}"

    # server=consul
    # IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $server)
    # log "$server $ curl ${IP}/v1/agent/members | jq | grep Addr"

    # server=consul
    # IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $server)
    # log "$server $ curl ${IP}:8500"
    # log "$server $ curl ${IP}:8500/v1/agent/members | jq | grep Addr"
    log "Traefik Proxy Dashboard: http://traefik.localhost"
    log ""

    consul_url="http://consul.localhost"
    #echo "Consul: $ curl ${consul_url}"
    echo "Consul Dashboard: ${consul_url}/ui"
    echo "curl ${consul_url}/v1/agent/members | jq | grep Addr"

    log ""
    echo "Vault: http://vault.localhost/ui"

    # server=vault
    # IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $server)
    # log "$server $ curl ${IP}:8200"
    # log "$server $ http://${IP}:8200/ui"

    #log "$ curl ${IP}:8500/v1/agent/members | jq | grep Addr"

    # log "Vault UI: http://${VAULT_ADDR}/ui"
    # log ""
    # log "$(docker logs dev-vault 2>&1 | grep 'Unseal Key')"
    # log "$(docker logs dev-vault 2>&1 | grep 'Root Token')"
    # log "======================================="
    # log ""
    # log "$ export VAULT_ADDR=http://${VAULT_ADDR}"
    # log "Hint: $ curl \$VAULT_ADDR/v1/sys/health | jq"
    # log ""
    # log "To stop, run: 'make stop-dev' or './bin/stop-dev.sh'"
}

#setup
main