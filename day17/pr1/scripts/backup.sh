#!/bin/bash

DB_NAME=$1
BACKUP_DIR=$2
DATE=$(date +%F_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"
LOG_FILE="$BACKUP_DIR/backup.log"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Perform the backup and log output
echo "Starting backup for database $DB_NAME at $DATE" >> $LOG_FILE
pg_dump -U postgres $DB_NAME > $BACKUP_FILE 2>> $LOG_FILE

if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE" >> $LOG_FILE
else
    echo "Backup failed for database $DB_NAME" >> $LOG_FILE
fi

# Optional: Remove backups older than 7 days
find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -exec rm {} \; >> $LOG_FILE 2>&1
