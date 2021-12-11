#!/usr/bin/env sh

KEY=
URL=http://vault:8200

echo "Starting unsealer"
while true
do
    status=$(curl -s $URL/v1/sys/seal-status | jq '.sealed')
    if [ true = "$status" ]
    then
        echo "Unsealing"
        curl -s --request PUT --data "{\"key\": \"$KEY\"}" $URL/v1/sys/unseal
    fi
    sleep 10
done
