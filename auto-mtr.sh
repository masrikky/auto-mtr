#!/bin/bash

# Check if an IP address is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

# Define the target host from the first argument
TARGET=$1

# Generate a timestamp (YYYYMMDD format)
DATESTAMP=$(date +"%Y%m%d")

# Define the base directory for storing logs
BASE_DIR="/usr/share/nginx/mtr/${DATESTAMP}/${TARGET}"

# Create the directory if it doesn't exist
if [ ! -d "$BASE_DIR" ]; then
    echo "Directory $BASE_DIR doesn't exist. Creating..."
    mkdir -p "$BASE_DIR"
else
    echo "Directory $BASE_DIR already exists. Writing logs..."
fi

# Generate a detailed timestamp (for the log file)
TIMESTAMP=$(date +"%H%M%S")

# Define the log file name with the detailed timestamp
LOGFILE="${BASE_DIR}/mtr_log_${TARGET}_${TIMESTAMP}.txt"

# Run mtr for the target IP address and log the output
echo "Running mtr to $TARGET at $(date)" > $LOGFILE
mtr -r -c 20 $TARGET >> $LOGFILE 2>&1
echo "-----------------------------" >> $LOGFILE

echo "mtr completed and logged in $LOGFILE"