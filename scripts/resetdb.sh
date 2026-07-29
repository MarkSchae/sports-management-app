#!/usr/bin/env bash

set -euo pipefail # -e, exit on any error with bash commands. -u, undefined variable error. -o, pipeline command fails means the whole pipeline fails

# Load environment variables
set -a # Auto export of variables
source .env # File where the variables come from
set +a # Stop exporting

# Validate required variable exists. Null command checking if variable returns else throw error.
: "${DB_USER:?Missing DB_USER}"
: "${DB_PASSWORD:?Missing DB_PASSWORD}"
: "${DB_HOST:?Missing DB_HOST}"
: "${DB_PORT:?Missing DB_PORT}"
: "${DB_NAME:?Missing DB_NAME}"

DB="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"

echo "Resetting database..."

psql "$DB" -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;" # -c, single sql line

bash scripts/migrate.sh