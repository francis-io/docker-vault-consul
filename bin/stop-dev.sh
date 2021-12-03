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

docker stop dev-vault > /dev/null 2>&1
log "Vault stopped."