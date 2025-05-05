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
rclone sync "${LOCAL_BASE_DIR}" "${REMOTE_BASE_DIR}" --drive-use-trash=false

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
