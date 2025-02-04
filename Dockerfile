# Use the rclone image as the base image.
FROM rclone/rclone

# Set default environment variables (optional defaults)
ENV CRON_TIME="40 * * * *" \
    LOCAL_BASE_DIR="/data" \
    REMOTE_BASE_DIR="GDrive:Backups/Alfred"

# Copy the backup script into the container.
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

# Copy the entrypoint script.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Override the base image's entrypoint and use our entrypoint.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
