

## Build

`docker build -t rclone_cron .`

## Setup

Run `rclone config` to generate a rclone.conf file

## Running
```
docker run --rm -d -e TZ="America/New_York" -e CRON_TIME="54 19 * * *" -e LOCAL_BASE_DIR="/data" -e REMOTE_BASE_DIR="GDrive:Backups/Test" -v ./config/:/config/rclone  -v ./test/:/data/test rclone_cron
```

## Compose Setup

```
  rclone_cron:
    build: rclone-cron/.
    environment:
      - CRON_TIME="5 * * * *"
      # These should not have spaces or quotes
      - LOCAL_BASE_DIR=/data/
      - REMOTE_BASE_DIR=GDrive:Backups/Alfred/
    volumes :
      - ./rclone-cron/config:/config/rclone

      # All folders to be syncd should be in /data/[folder_name] 
      - /data/docker/vault-backups/:/data/vault-backups
```
