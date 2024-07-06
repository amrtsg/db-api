#!/bin/bash

# Variables
CONTAINER_NAME="postgrescont"
DB_USER="amr"
DB_NAME="postgres"
BACKUP_PATH="backups/"

# Ensure the backup directory exists
mkdir -p $BACKUP_PATH

# Generate a timestamp for the backup file
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="backup_$DATE.dump"  # Use .dump extension for custom format

# Run pg_dump to create the backup in custom format
docker exec $CONTAINER_NAME pg_dump -U $DB_USER -d $DB_NAME -Fc > "$BACKUP_PATH/$BACKUP_FILE"

# Print a message
echo "Backup completed: $BACKUP_PATH/$BACKUP_FILE"