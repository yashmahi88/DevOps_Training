#!/bin/bash

# log_checker.sh
LOGFILE="/var/log/syslog"
ERROR_LOG="/var/log/error_analysis.log"

grep -i "error" $LOGFILE | while read -r line; do
    echo "Found Error: $line" >> $ERROR_LOG
    # Simple pattern matching for troubleshooting
    if echo "$line" | grep -q "out of memory"; then
        echo "Troubleshooting: Check memory usage and consider increasing swap space." >> $ERROR_LOG
    fi
done
