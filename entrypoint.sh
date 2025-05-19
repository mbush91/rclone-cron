#!/bin/sh
set -e

# 1) Default schedule if none supplied
: "${CRON_TIME:=45 19 * * *}"
echo "Using cron schedule: ${CRON_TIME}"

# 2) Export environment variables for cron jobs
printenv | grep -v "no_proxy" > /etc/environment

# 3) Write a /etc/cron.d file (correct for /etc/cron.d to include 'root')
cat <<EOF > /etc/cron.d/my-cron
${CRON_TIME} root . /etc/environment; /usr/local/bin/backup.sh >> /proc/1/fd/1 2>&1
EOF

# 4) Correct permissions
chmod 0644 /etc/cron.d/my-cron

# 🚫 REMOVE THIS — Don't load /etc/cron.d with crontab; cron automatically loads it
# crontab /etc/cron.d/my-cron

# 5) Run cron in the foreground so Docker stays alive
exec cron -f
