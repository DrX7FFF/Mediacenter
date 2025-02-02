#! /bin/bash

#   -p 7878:7878 \

# Optional Volumes:
#   -v /path/to/movies:/movies `#optional` \
#   -v /path/to/download-client-downloads:/downloads `#optional` \

  # -e PUID=1000 \
  # -e PGID=1000 \

docker run -d \
  --name=radarr \
  --network container:vpn \
  -e TZ=Europe/Paris \
  -e PUID=0 \
  -e PGID=0 \
  -v /storage/.config/dockers/radarr:/config \
  -v /media/HD1:/data \
  --restart unless-stopped \
  --platform linux/arm64 \
  lscr.io/linuxserver/radarr:latest
