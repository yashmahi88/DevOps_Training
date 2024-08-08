#!/bin/bash

# Define variables
LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/var/log/archive"
MAX_SIZE=10000000  # 10MB
DAYS_TO_KEEP=30

# Create archive directory if it does not exist
if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir -p "$ARCHIVE_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Unable to create archive directory $ARCHIVE_DIR" >&2
        exit 1
    fi
fi

# Rotate logs
for log_file in $LOG_DIR/*.log; do
    if [ -f "$log_file" ]; then
        SIZE=$(stat -c%s "$log_file")
        if [ $SIZE -gt $MAX_SIZE ]; then
            ARCHIVE_FILE="$ARCHIVE_DIR/$(basename $log_file).$(date +%F-%H-%M-%S).gz"
            mv "$log_file" "$ARCHIVE_FILE"
            if [ $? -ne 0 ]; then
                echo "Error: Unable to move $log_file to $ARCHIVE_FILE" >&2
                continue
            fi
            gzip "$ARCHIVE_FILE"
            if [ $? -ne 0 ]; then
                echo "Error: Unable to compress $ARCHIVE_FILE" >&2
                continue
            fi
            echo "Archived and compressed $log_file to $ARCHIVE_FILE.gz"
        fi
    fi
done

# Delete old logs
find "$ARCHIVE_DIR" -type f -mtime +$DAYS_TO_KEEP -exec rm {} \;
if [ $? -ne 0 ]; then
    echo "Error: Unable to delete old logs from $ARCHIVE_DIR" >&2
    exit 1
fi

echo "Log rotation and cleanup completed."
