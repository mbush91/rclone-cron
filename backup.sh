#!/bin/bash
set -e

echo "[$(date)] Starting backup from ${LOCAL_BASE_DIR} to ${REMOTE_BASE_DIR}"

# Stop containers passed in by env variables (CONTAINERS_TO_PAUSE)
if [ -n "$CONTAINERS_TO_PAUSE" ]; then
    echo "Stopping containers: $CONTAINERS_TO_PAUSE"
    for container in $(echo $CONTAINERS_TO_PAUSE | tr ',' '\n'); do
        echo "Stopping container $container"
        docker stop "$container"
    done
else
    echo "No containers to stop."
fi

# Run the rclone sync command; change 'sync' to 'copy' if needed.
echo "Running rclone sync from ${LOCAL_BASE_DIR} to ${REMOTE_BASE_DIR}"
rclone sync "${LOCAL_BASE_DIR}" "${REMOTE_BASE_DIR}" --drive-use-trash=false -v --progress

# Check if the rclone command was successful
if [ $? -ne 0 ]; then
    echo "Rclone sync failed."
else
    echo "Rclone sync completed successfully."
fi

# Restart containers passed in by env variables (CONTAINERS_TO_PAUSE)
if [ -n "$CONTAINERS_TO_PAUSE" ]; then
    echo "Starting containers: $CONTAINERS_TO_PAUSE"
    for container in $(echo $CONTAINERS_TO_PAUSE | tr ',' '\n'); do
        echo "Starting container $container"
        docker start "$container"
    done
else
    echo "No containers to start."
fi

echo "[$(date)] Backup complete."
