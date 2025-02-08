#!/bin/bash
  # --net=host \

docker run -d \
  --name=jellyfin \
  -e TZ=Europe/Paris \
  -e PUID=0 \
  -e PGID=0 \
  -p 7459:7359 \
  -p 8196:8096 \
  -v /storage/.config/dockers/jellyfin/config:/config \
  -v /storage/.config/dockers/jellyfin/cache:/cache \
  -v /media/HD1:/media:ro \
  --restart unless-stopped \
  --platform linux/arm64 \
  jellyfin/jellyfin
