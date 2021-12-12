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

_vault_status() {
  _get_url_status() {
      curl --output /dev/null -s -w "%{http_code}" --location ${1}/v1/sys/health
  }

  vault_status=$(_get_url_status ${1})

  if [[ ${vault_status} == "200" ]]; then
      echo "active"
  else
      echo "${vault_status}"
  fi
}

wait_until_vault_is_unsealed() {
  # Pass url:port
  log "INFO: Waiting for vault to start..."

  while [[ $(_vault_status ${1}) != "active" ]]; do
      if [ ${DEBUG:-false} == 'true' ] ; then log "DEBUG: Waiting for vault..." ; fi
      sleep 1
  done

  log "INFO: Vault has been unsealed and is active."
}

main() {
  #DEBUG=true # TODO: dont set this here

  consul_url="http://consul.localhost" # TODO: dont hardcode here
  vault_url="http://vault.localhost"

  wait_until_vault_is_unsealed ${vault_url}

  # Downloading jq in docker instead of having it as a requirement. Kinda nuts, I know...
  jq_container=jiapantw/jq-alpine
  docker pull ${jq_container} > /dev/null 2>&1

  unseal_key=$(cat .unseal-keys/unseal-keys.json | docker run -i --rm ${jq_container} --raw-output '.keys | .[0]' )
  root_token=$(cat .unseal-keys/unseal-keys.json | docker run -i --rm ${jq_container} --raw-output '.root_token')

  log "======================================="
  log ""
  log "Traefik Proxy Dashboard: http://traefik.localhost/dashboard/#/"
  log ""

  log "Consul Dashboard: ${consul_url}/ui"
  log "Try: $ curl ${consul_url}/v1/agent/members"
  log ""

  log "Vault UI: ${vault_url}/ui"
  log "Try: $ curl ${vault_url}/v1/sys/health"
  log ""
  log "Vault Unseal Key: ${unseal_key}"
  log "Vault Root Token: ${root_token}"
  log ""
  log "======================================="
}

main