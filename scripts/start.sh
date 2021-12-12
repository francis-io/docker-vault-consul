#!/usr/bin/env bash

# Make the script exit on error. Add "|| true to override this".
set -o errexit

# Exit when the script tries to use an undeclared variable.
set -o nounset

# Get the exit status of the last thing that failed. Useful when using pipes.
set -o pipefail

count="$((${1}-1))" # To account for the leader

# Defaults to a count of 2 to create a 3 node cluster, including the "leader"
docker-compose up --build --detach --scale consul-workers=${count:-2}   # --scale vault-workers=$(or $(count), 2)
./scripts/return-cluster-info.sh