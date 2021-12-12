#!/usr/bin/env sh

# TODO: dont hardcode http

# DEBUG: "true" - can be set as env var

log() {
  echo "$(date +'%H:%M:%S'): $*" >&2
}

package_installed() {
    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Checking $1 is installed..." ; fi

    # using akp --no-cache supresses the warning that i dont have anything cached.
    apk list --installed --no-cache | grep "$1" >/dev/null 2>/dev/null \
    || { log "INFO: require ${1}, but it's not installed. Aborting..." >&2; exit 1; }

    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: $1 is installed." ; fi
}

# verify_variables_are_set() {
#     if [[ $# -eq 0 ]] ; then log "INFO: No paramiters passed. Check docs. Exiting...."; exit 1; fi
# }

vault_status() {
    # Pass url:port
    # https://www.vaultproject.io/api/system/health
    # 429 if unsealed and standby, 501 if not initialized, 503 if sealed

    _get_url_status() {
        curl --output /dev/null -s -w "%{http_code}" --location "${1}"/v1/sys/health #TODO: expand params
    }

    vault_status=$(_get_url_status $1)

    # I dont like case statements
    if [[ $vault_status == "503" ]]; then
        echo "sealed"

    elif [[ $vault_status == "501" ]]; then
        echo "not_initialized"

    elif [[ $vault_status == "429" ]]; then
        echo "unsealed_and_standby"

    else
        echo "$vault_status"
    fi
}

wait_until_vault_starts() {
    # Pass url:port
    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Waiting for vault to start..." ; fi

    until [[ $(vault_status $1) != "000" ]]; do #TODO: fix hack
        if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Waiting for vault..." ; fi
        sleep 1
    done

    log "INFO: Vault has started."
}

vault_initialize() {
    # Pass url:port
    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Attempting to initialize..." ; fi

    while [[ $(vault_status $1) == "not_initialized" ]]; do
        curl --request POST --silent http://${1}/v1/sys/init \
            --data '{"secret_shares": 1, "secret_threshold": 1}' \
            > /unseal-keys/unseal-keys.json # TODO: create var for file location, env var

        if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: $(cat /unseal-keys/unseal-keys.json)" ; fi
    done

    log "INFO: Vault initialized successfully."
}

vault_unseal() {
    # Pass url:port
    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Attempting to unseal..." ; fi

    while [[ $(vault_status $1) == "sealed" ]]; do
        unseal_key=$(jq -r ' .keys | .[0]' /unseal-keys/unseal-keys.json)

        if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Unseal key: $unseal_key" ; fi

        curl --request PUT --silent --output /dev/null \
            --header "Content-Type: application/json" \
            --data '{"key":"'${unseal_key}'"}' \
            http://${1}/v1/sys/unseal
    done

    log "INFO: Vault unsealed successfully."
}

setup() {
    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Starting local setup..." ; fi

    #verify_variables_are_set TODO: not working how i want it to
    package_installed curl

    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Local setup finished." ; fi
}

main() {
    VAULT=${VAULT_URL}:${VAULT_PORT} # TODO: should check these are set in env

    # Wait for vault to become active
    wait_until_vault_starts "${VAULT}"

    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Vault status: $(vault_status $VAULT) " ; fi
    # Vault needs to be initialized and then unsealed.
    if [[ $(vault_status $VAULT) == "not_initialized" ]]; then
        vault_initialize ${VAULT}
    fi

    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Vault status: $(vault_status $VAULT) " ; fi
    if [[ $(vault_status ${VAULT}) == "sealed" ]]; then
        vault_unseal ${VAULT}
    fi

    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Vault status: $(vault_status $VAULT) " ; fi

    log "INFO: Initialization and unsealing complete!"

    if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: docker-compose can't run one container and exit, so sleeping forever..." ; fi
    sleep infinity
}

setup
main
