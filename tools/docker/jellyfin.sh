#!/bin/bash

docker run -d \
  --name=jellyfin \
  --net=host \
  -e TZ=Europe/Paris \
  -e PUID=0 \
  -e PGID=0 \
  -v /storage/.config/dockers/jellyfin/config:/config \
  -v /storage/.config/dockers/jellyfin/cache:/cache \
  -v /media/HD1:/media:ro \
  --restart unless-stopped \
  --platform linux/arm64 \
  jellyfin/jellyfin
