#!/usr/bin/env bash
set -euo pipefail

# Carrega variáveis de ambiente locais, se existir
if [ -f ".env" ]; then
  # shellcheck disable=SC1091
  source ".env"
fi

: "${DB_HOST:?}" "${DB_PORT:?}" "${DB_NAME:?}" "${DB_USER:?}" "${DB_PASSWORD:?}"

PGURI="postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
psql "$PGURI" -c "SELECT current_database(), current_user;"


