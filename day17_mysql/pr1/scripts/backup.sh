#!/bin/bash

# Set variables
DATABASE_NAME=mydatabase
BACKUP_DIR=/var/backups/mysql
DATE=$(date +"%Y-%m-%d")

# Create backup file name
BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_${DATE}.sql"

# Dump database to backup file
mysqldump -u myuser -p${database_password} ${DATABASE_NAME} > ${BACKUP_FILE}

# Compress backup file
gzip ${BACKUP_FILE}

# Remove old backups (keep only 7 days)
find ${BACKUP_DIR} -type f -mtime +7 -delete
