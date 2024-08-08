#!/bin/bash

# Configuration
LOG_DIR="/var/log"
ARCHIVE_DIR="/var/log/archive"
MAX_LOG_AGE=30 # days
LOG_SIZE_LIMIT=10000000 # bytes (10 MB)
ERROR_LOG="/var/log/log_management_error.log"
INFO_LOG="/var/log/log_management.log"

# Ensure archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Function to rotate and compress logs
rotate_logs() {
    echo "Starting log rotation..." >> "$INFO_LOG"
    for log_file in "$LOG_DIR"/*.log; do
        if [ -f "$log_file" ]; then
            # Check log size
            if [ $(stat -c%s "$log_file") -gt $LOG_SIZE_LIMIT ]; then
                timestamp=$(date +'%Y%m%d%H%M%S')
                mv "$log_file" "$ARCHIVE_DIR/$(basename "$log_file")-$timestamp"
                gzip "$ARCHIVE_DIR/$(basename "$log_file")-$timestamp"
                echo "Log file $(basename "$log_file") rotated and compressed." >> "$INFO_LOG"
            fi
        fi
    done
}

# Function to delete old logs
delete_old_logs() {
    echo "Starting deletion of old logs..." >> "$INFO_LOG"
    find "$ARCHIVE_DIR" -type f -mtime +$MAX_LOG_AGE -exec rm {} \;
    echo "Old logs deleted." >> "$INFO_LOG"
}

# Function to show archived logs
show_archived_logs() {
    echo "Listing archived logs:"
    ls -lh "$ARCHIVE_DIR"
}

# Function to check if directories exist
check_directories() {
    if [ ! -d "$LOG_DIR" ]; then
        echo "Error: Log directory $LOG_DIR does not exist." >&2
        exit 1
    fi

    if [ ! -d "$ARCHIVE_DIR" ]; then
        echo "Error: Archive directory $ARCHIVE_DIR does not exist." >&2
        exit 1
    fi
}

# Main script execution
{
    check_directories
    rotate_logs
    delete_old_logs
    show_archived_logs
} || {
    echo "An error occurred during log management." >> "$ERROR_LOG"
    exit 1
}
