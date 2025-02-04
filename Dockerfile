# Use the rclone image as the base image.
FROM rclone/rclone

# Set default environment variables.
ENV CRON_TIME="40 * * * *" \
    LOCAL_BASE_DIR="/data" \
    REMOTE_BASE_DIR="GDrive:Backups/Alfred"

# Copy the backup script into the container.
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

# For Alpine-based images, cron jobs for the root user are stored in /etc/crontabs/root.
# Create the cron job that runs the backup script according to CRON_TIME.
RUN echo "$CRON_TIME /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1" > /etc/crontabs/root

# Create an empty log file so that cron can write output.
RUN touch /var/log/backup.log

# Override the base image's entrypoint.
ENTRYPOINT []

# Run the cron daemon in the foreground with a log level of 2.
CMD ["crond", "-f", "-l", "2"]
