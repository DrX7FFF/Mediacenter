#! /bin/bash

#   -v /path/to/downloadclient-downloads:/downloads `#optional` \
#   -p 8989:8989 \

docker run -d \
  --name=sonarr \
  --network container:vpn \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Paris \
  -v /storage/.config/dockers/sonarr:/config \
  -v /media/HD1:/data \
  --restart unless-stopped \
  --platform linux/arm64 \
  lscr.io/linuxserver/sonarr:latest
