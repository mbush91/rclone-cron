#!/bin/sh
# Generate the crontab file using the runtime CRON_TIME variable
echo "${CRON_TIME} /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1" > /etc/crontabs/root

# Ensure the log file exists (optional)
touch /var/log/backup.log

# Execute cron in the foreground with log level 2
exec crond -f -l 2
