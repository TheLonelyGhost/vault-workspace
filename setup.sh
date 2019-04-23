#!/usr/bin/env bash

set -euo pipefail

docker-compose up -d --scale vault=3 --scale consul=5
trap -- 'docker-compose down' SIGINT SIGHUP

export VAULT_ADDR='http://127.0.0.1:8200'

printf '\n>>>  Waiting for Vault to come online... '
while true; do
  if ! curl --connect-timeout 1 "${VAULT_ADDR}/v1/sys/health" 2>/dev/null | jq -r '.version' &>/dev/null; then
    sleep 1
  else
    break
  fi
done
printf 'Online!\n'

tmpfile=$(mktemp)

printf '>>>  Initializing and unsealing the Vault cluster\n'

vault operator init -key-shares=1 -key-threshold=1 -format=json > "$tmpfile"
trap -- "if [ -e '$tmpfile' ]; then rm '$tmpfile'; fi" EXIT

vault operator unseal "$(jq -r '.unseal_keys_b64[]' "$tmpfile")" 1>/dev/null

printf 'export VAULT_UNSEAL_TOKEN="%s"\nexport VAULT_TOKEN="%s"\nexport VAULT_ADDR="%s"\n' "$(jq -r '.unseal_keys_b64[]' "$tmpfile")" "$(jq -r '.root_token' "$tmpfile")" "$VAULT_ADDR" > ./.vault-info

printf '>>>  Vault cluster is created. To destroy, run %s\n' "\`./destroy.sh'"
printf '>>>  To use with the %s command, first run %s\n' "\`vault'" "\`source ./.vault-info'"

printf '\n'
vault status
