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
    IP="$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' lb)"

    echo "Load Balancer IP is: $IP"

    END=10
    echo "Curling the LB $END times..."

    for ((i=1;i<=END;i++)); do
      curl $IP; echo
    done
}

main