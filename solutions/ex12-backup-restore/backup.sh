#!/usr/bin/env bash
set -euo pipefail

if [ -f ".env" ]; then
  # shellcheck disable=SC1091
  source ".env"
fi
: "${DB_HOST:=localhost}" "${DB_PORT:=5432}" "${DB_NAME:=hospital}" "${DB_USER:=rhp}" "${DB_PASSWORD:=rhp_password}"
export PGPASSWORD="${DB_PASSWORD}"

mkdir -p backups
TS="$(date +%Y%m%d_%H%M%S)"
FILE="backups/${DB_NAME}_${TS}.dump"
pg_dump -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -d "${DB_NAME}" -Fc -f "${FILE}"
echo "Backup criado: ${FILE}"


