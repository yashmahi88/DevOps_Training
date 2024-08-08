#!/bin/bash

# Define log file
LOGFILE="/var/log/system_performance.log"

# Function to log messages with timestamp
log_message() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - ${message}" >> "${LOGFILE}"
}

# Function to check disk usage
check_disk_usage() {
    local disk_usage
    disk_usage=$(df -h 2>> "${LOGFILE}")
    if [ $? -ne 0 ]; then
        log_message "Error checking disk usage."
        return 1
    fi
    echo "Disk Usage:"
    echo "${disk_usage}"
    log_message "Disk usage checked."
}

# Function to check memory usage
check_memory_usage() {
    local mem_usage
    mem_usage=$(free -h 2>> "${LOGFILE}")
    if [ $? -ne 0 ]; then
        log_message "Error checking memory usage."
        return 1
    fi
    echo "Memory Usage:"
    echo "${mem_usage}"
    log_message "Memory usage checked."
}

# Function to check CPU load
check_cpu_load() {
    local cpu_load
    cpu_load=$(top -bn1 | grep "Cpu(s)" 2>> "${LOGFILE}")
    if [ $? -ne 0 ]; then
        log_message "Error checking CPU load."
        return 1
    fi
    echo "CPU Load:"
    echo "${cpu_load}"
    log_message "CPU load checked."
}

# Main script execution
log_message "System performance check started."

check_disk_usage
check_memory_usage
check_cpu_load

log_message "System performance check completed."
