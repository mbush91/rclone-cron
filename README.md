

## Build

`docker build -t rclone-cron .`

## Setup

Run `rclone config` to generate a rclone.conf file

## Running
```
docker run --rm -d -e LOCAL_BASE_DIR="/data" -e REMOTE_BASE_DIR="GDrive:Backups/Alfred" -v ./config/:/config/rclone  -v ./test/:/data/test rclone-cron
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
