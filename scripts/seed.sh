#!/usr/bin/env bash

# Seed data is not just test data — it is the initial or required data a system needs after migrations, and it must be written in an idempotent way so it can run multiple times without causing issues.
# Seed data is used to link schema to important data but keeping it flexible(change does not require migrations)
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

# Build connection string
DB="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"

psql "$DB" -v ON_ERROR_STOP=1 -f db/seeds/seed.sql # Run sql commands from a file


# Seed data reduces the need for risky migrations(schema must be seen as fixed for the most part, use data inserts in seperate tables for felxiblity)
# Migration vs Data Update:
# 
# Migration = changes the structure of the database (tables, columns, types, constraints).
#             High risk, requires controlled deployment, can break the app if wrong.
#
# Data Update = changes the actual data inside the database (rows).
#               Low risk, can be done anytime, no redeploy needed.
#
# Rule of thumb:
# - If you're changing HOW the database is built → migration
# - If you're changing WHAT the database contains → data update




# Mental model (quick):
# Migrations = how the database is built (structure)
# Seeds = required starting data the system depends on
# Data updates = what the system contains during normal use (runtime changes)
#
# Why seeds exist:
# After a reset/migration, the DB is empty. Seeds ensure the system still works
# by inserting essential baseline data (e.g. roles, categories, admin user).
#
# How seeds are used:
# Run after migrations to populate required default/reference data.
# Must be safe to run multiple times (idempotent) without duplicating data.
#
# Rule of thumb:
# - If it defines structure → migration
# - If the app needs it to function from day 1 → seed
# - If users/game/events create it → runtime data