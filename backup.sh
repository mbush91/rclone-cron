#!/bin/bash

echo "[$(date)] Starting backup from ${LOCAL_BASE_DIR} to ${REMOTE_BASE_DIR}"

# Run the rclone sync command; change 'sync' to 'copy' if needed.
rclone sync "${LOCAL_BASE_DIR}" "${REMOTE_BASE_DIR}" --drive-use-trash=false

echo "[$(date)] Backup complete."