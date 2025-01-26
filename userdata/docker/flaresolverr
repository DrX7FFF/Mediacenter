#! /bin/bash

#   -p 8191:8191 \

docker run -d \
  --name=flaresolverr \
  --network container:vpn \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Paris \
  -e LOG_LEVEL=warning \
  --restart unless-stopped \
  --platform linux/arm64 \
  ghcr.io/flaresolverr/flaresolverr:latest
