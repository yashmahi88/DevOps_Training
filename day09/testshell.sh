#!/bin/bash

# Variables
APP_URL="http:/myapp.local/"  # Replace with your actual application URL
TEST_DURATION="45"  # Duration of stress test in seconds (5 minutes)

# Function to send traffic to the application
send_traffic() {
  echo "Sending traffic to $APP_URL for $TEST_DURATION seconds..."
  start_time=$(date +%s)
  end_time=$((start_time + TEST_DURATION))

  while [ $(date +%s) -lt $end_time ]; do
    curl -sS -o /dev/null $APP_URL
    sleep 1
  done
}

# Main script execution
echo "Starting stress test..."
send_traffic

echo "Stress test completed."

