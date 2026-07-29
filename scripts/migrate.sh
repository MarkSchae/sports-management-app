# Manual migrate script to commit and track database changes and produce migration files for reference

# Tells os to run this script using bash (env bash to be agnostic)
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

# Build connection string
DB="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"

echo "Running migrations against: $DB"

# Ensure migration tracking table exists
# Pass the block of SQL to the psql cli until SQL is seen again. Feed SQL block into psql via heredoc until SQL delimiter is reached.
psql "$DB" <<'SQL' # Do not expand variables inside the block
CREATE TABLE IF NOT EXISTS schema_migrations (
    filename TEXT PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT NOW()
);
SQL

# Loop safely over migration files
for file in db/migrations/*.sql; do # Run til done once per file
  [ -e "$file" ] || continue # Does the file already exsist? Skip to the next file if file does not exist

  filename=$(basename "$file") # Track only the file/basename and not the entire path

  # Check if migration already applied (safe parameter binding)
  # Connect to the db. Tupples only, unalinged output. -t = tuples only (no headers), -A = unaligned output (clean text).
  applied=$(psql "$DB" -tAc \ 
  # Creates a psql variable and injects where :fname.
    -v fname="$filename" \
    "SELECT 1 FROM schema_migrations WHERE filename = :'fname'") # Return 1 for every row that matches the filename
  # Check if migration has already been applied (exsists in the table of applied migrations).
  if [[ "$applied" == "1" ]]; then
    echo "Skipping $filename (already applied)"
    continue # Next file if migrations already applied
  fi # Closes the if statement loop

  echo "Applying $filename..."

  # Run migration in a transaction
  # Opens connection. Adds the migration file to the migration table. Runs the sql in the migrations.sql file. Committs last incase rollback is needed.
  psql "$DB" <<SQL
BEGIN;

\i $file 

INSERT INTO schema_migrations (filename)
VALUES ('$filename');

COMMIT;
SQL

  echo "Applied $filename"
done

echo "All migrations complete"