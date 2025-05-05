#!/bin/sh
set -e

# 1) Default schedule if none supplied
: "${CRON_TIME:=45 19 * * *}"
echo "Using cron schedule: ${CRON_TIME}"

# 2) Write a /etc/cron.d file
#    NOTE: in /etc/cron.d you need 6 fields: min hour dom mon dow user command
cat <<EOF > /etc/cron.d/my-cron
${CRON_TIME} root /usr/local/bin/backup.sh >> /proc/1/fd/1 2>&1
EOF

# 3) Correct permissions
chmod 0644 /etc/cron.d/my-cron

# 4) Ensure that we reload the cron tables (not strictly needed for fresh container)
crontab /etc/cron.d/my-cron

# 5) Run cron in the foreground so Docker stays alive
exec cron -f
