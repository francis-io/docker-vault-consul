#!/usr/bin/env bash

# Make the script exit on error. Add "|| true to override this".
set -o errexit

# Exit when the script tries to use an undeclared variable.
set -o nounset

# Get the exit status of the last thing that failed. Useful when using pipes.
set -o pipefail


VAULT_PORT=8200
#DEBUG=true # Set to true if you want status output

log() {
  echo "$(date +'%H:%M:%S'): $*" >&2
}

wait_for_url() {
    log "Testing $1"

    while [[ "$(curl -s -o /dev/null -L -w ''%{http_code}'' ${1})" != "200" ]]; do
        log "Waiting for ${1} to become available..." && sleep 1;
        if [ ${DEBUG:-false} == 'true' ] ; then log DEBUG: "$(curl -sb -H "Accept: application/json" ${1}/v1/sys/health)" ; fi
    done

    log "OK!"
}

exists () {
   type "$1" >/dev/null 2>/dev/null || { log "I require ${1}, but it's not installed. Aborting..." >&2; exit 1; }
}

# A little dumb, but should work on linux and mac
docker_running() {
    docker ps >/dev/null 2>/dev/null || { log "I require docker to be running, but it's not. Aborting..." >&2; exit 1; }
}

setup() {
    exists docker
    docker_running
}

main() {
    log "Vault starting..."
    docker run --rm --cap-add=IPC_LOCK -d --name=dev-vault vault &> /dev/null

    IP="$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dev-vault)"
    VAULT_ADDR="${IP}:${VAULT_PORT}"

    wait_for_url http://${VAULT_ADDR}

    log ""
    log "======================================="
    log "Vault API Address: ${VAULT_ADDR}"
    log "Vault UI: http://${VAULT_ADDR}/ui"
    log ""
    log "$(docker logs dev-vault 2>&1 | grep 'Unseal Key')"
    log "$(docker logs dev-vault 2>&1 | grep 'Root Token')"
    log "======================================="
    log ""
    log "$ export VAULT_ADDR=http://${VAULT_ADDR}"
    log "Hint: $ curl \$VAULT_ADDR/v1/sys/health | jq"
    log ""
    log "To stop, run: 'make stop-dev' or './bin/stop-dev.sh'"
}

setup
main