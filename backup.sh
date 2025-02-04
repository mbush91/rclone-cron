# Use rclone as the base image
FROM rclone/rclone

# Set environment variables with defaults.
ENV CRON_TIME="0 * * * *" \
    LOCAL_BASE_DIR="/data" \
    REMOTE_BASE_DIR="GDrive:Backups/Alfred"

# Install cron (assuming a Debian-based image)
RUN apt-get update && apt-get install -y cron && rm -rf /var/lib/apt/lists/*

# Copy the backup script into the container and make it executable.
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

# Create the cron job file.
# This will run the backup script at the schedule defined by CRON_TIME.
RUN echo "$CRON_TIME root /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1" > /etc/cron.d/backup-cron && \
    chmod 0644 /etc/cron.d/backup-cron && \
    crontab /etc/cron.d/backup-cron

# Create a log file so that cron has somewhere to write output.
RUN touch /var/log/backup.log

# Start cron in the foreground.
CMD ["cron", "-f"]
