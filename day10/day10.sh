#!/bin/bash

# Script Initialization

# Variables
LOG_FILE="/var/log/system_monitor.log"
REPORT_FILE="/tmp/system_report_$(date +%Y%m%d-%H%M%S).txt"
THRESHOLD_CPU=90  # Example: 90% CPU threshold
THRESHOLD_MEM=90  # Example: 90% Memory threshold
ADMIN_EMAIL="yashmahi0404@gmail.com"

# Check if required commands are available
REQUIRED_COMMANDS=("top" "free" "df" "netstat" "systemctl" "ping" "mail")
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "$cmd" > /dev/null; then
        echo "Error: $cmd command not found. Ensure it is installed and accessible." >&2
        exit 1
    fi
done

# System Metrics Collection

function collect_system_metrics() {
    echo "System Metrics" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    echo "CPU Usage:" >> "$REPORT_FILE"
    top -bn1 | head -n10 >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    echo "Memory Usage:" >> "$REPORT_FILE"
    free -h >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    echo "Disk Space:" >> "$REPORT_FILE"
    df -h >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    echo "Network Statistics:" >> "$REPORT_FILE"
    netstat -s | head -n10 >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
}

# Log Analysis

function analyze_logs() {
    echo "Log Analysis" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    echo "Recent syslog entries:" >> "$REPORT_FILE"
    tail -n 20 /var/log/syslog >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
}

# Health Checks

function perform_health_checks() {
    echo "Health Checks" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    echo "Service Status:" >> "$REPORT_FILE"
    systemctl status apache2 >> "$REPORT_FILE"
    #systemctl status mysql >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    echo "Connectivity Tests:" >> "$REPORT_FILE"
    ping -c 3 google.com >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
}

# Alerting Mechanism

function check_alerts() {
    echo "Alerts" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    # Check CPU and Memory thresholds
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d "." -f1)
    local mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d "." -f1)

    if [[ "$cpu_usage" -ge "$THRESHOLD_CPU" ]]; then
        echo "CPU usage is above threshold: $cpu_usage%" >> "$REPORT_FILE"
        echo "Sending alert to $ADMIN_EMAIL..."
        echo "Subject: ALERT - High CPU Usage on $(hostname)" | mail -s "ALERT - High CPU Usage on $(hostname)" "$ADMIN_EMAIL"
    fi

    if [[ "$mem_usage" -ge "$THRESHOLD_MEM" ]]; then
        echo "Memory usage is above threshold: $mem_usage%" >> "$REPORT_FILE"
        echo "Sending alert to $ADMIN_EMAIL..."
        echo "Subject: ALERT - High Memory Usage on $(hostname)" | mail -s "ALERT - High Memory Usage on $(hostname)" "$ADMIN_EMAIL"
    fi
}

# Report Generation

function generate_report() {
    echo "Generating System Report..."
    echo "System Report" > "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    collect_system_metrics
    analyze_logs
    perform_health_checks
    check_alerts

    echo "System report generated: $REPORT_FILE"
}

generate_report
