#!/bin/bash

# Variables
ROOT_DIR=$(dirname "$(dirname "$(realpath "$0")")")
CONTAINER_NAME="postgrescont"
DB_USER="amr"
DB_NAME="postgres"
BACKUP_PATH="$ROOT_DIR/backups"
BACKUP_FILE="backup_2024-07-05_14-58-52.dump"
CONTAINER_BACKUP_FILE="/backup.sql"  # Path inside the container

# Check if the backup file exists
if [ ! -f "$BACKUP_PATH/$BACKUP_FILE" ]; then
  echo "Backup file not found: $BACKUP_PATH/$BACKUP_FILE"
  exit 1
fi

# Copy the backup file into the container
docker cp "$BACKUP_PATH/$BACKUP_FILE" "$CONTAINER_NAME:$CONTAINER_BACKUP_FILE"

# Drop existing database objects
docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

# Restore the backup using pg_restore
docker exec -i "$CONTAINER_NAME" pg_restore -U "$DB_USER" -d "$DB_NAME" -v "$CONTAINER_BACKUP_FILE"

# Print a message
echo "Restore completed from: $BACKUP_PATH/$BACKUP_FILE"