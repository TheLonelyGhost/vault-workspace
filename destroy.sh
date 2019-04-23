#!/usr/bin/env bash

set -euo pipefail

docker-compose down
if [ -e './.vault-info' ]; then
  rm ./.vault-info
fi

printf '\n>>>  %s\n\n' "Vault HA cluster is destroyed. To create again, run \`./setup.sh'."
