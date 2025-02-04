

## Build

`docker build -t rclone-cron .`

## Compose Setup

```

```

```
docker run -d -e LOCAL_BASE_DIR="/data" -e REMOTE_BASE_DIR="GDrive:Backups/Alfred" -v ./config/:/config/rclone  -v ./test/:/data/test rclone-cron
```
