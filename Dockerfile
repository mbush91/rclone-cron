# Use Debian Bookworm Slim as base image
FROM debian:bookworm-slim

# Set environment variables to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages: curl for downloading rclone, cron for the cron job
RUN apt-get update && \
    apt-get install -y \
    curl \
    cron \
    zip \
    procps \
    unzip \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Install rclone
RUN curl https://rclone.org/install.sh | bash

# Create a directory for rclone configuration (optional, for storing rclone configs)
RUN mkdir -p /root/.config/rclone

# Copy the backup script into the container
COPY backup.sh /usr/local/bin/backup.sh

# Make sure the backup script is executable
RUN chmod +x /usr/local/bin/backup.sh

# Copy the entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to the entrypoint.sh script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
