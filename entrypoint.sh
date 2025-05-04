#!/bin/bash

# Check if CRON_TIME is set and if not, set it to a default value
if [ -z "$CRON_TIME" ]; then
    echo "CRON_TIME not set, using default 45 19 * * *"
    CRON_TIME="45 19 * * *"
fi

# Set the cron job dynamically
echo "$CRON_TIME root /usr/local/bin/backup.sh" > /etc/cron.d/rclone-cron

# Set proper permissions for the cron job file
chmod 0644 /etc/cron.d/rclone-cron

# Start cron in the foreground
cron -f
