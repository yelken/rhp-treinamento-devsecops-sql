#!/usr/bin/env bash
set -euo pipefail

if [ -f ".env" ]; then
  # shellcheck disable=SC1091
  source ".env"
fi
: "${DB_HOST:=localhost}" "${DB_PORT:=5432}" "${DB_NAME:=hospital}" "${DB_USER:=rhp}" "${DB_PASSWORD:=rhp_password}"
export PGPASSWORD="${DB_PASSWORD}"

BACKUP_FILE="${1:-}"
if [ -z "${BACKUP_FILE}" ]; then
  echo "Uso: $0 backups/hospital_YYYYmmdd_HHMMSS.dump"
  exit 1
fi

RESTORE_DB="${DB_NAME}_restore"
createdb -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" "${RESTORE_DB}" || true
pg_restore -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -d "${RESTORE_DB}" --clean --if-exists "${BACKUP_FILE}"
echo "Restauração concluída em: ${RESTORE_DB}"


