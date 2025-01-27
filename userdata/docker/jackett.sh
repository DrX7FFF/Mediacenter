#! /bin/bash

# Pas utilisé
  # -v /storage/.config/dockers/jackett/blackhole:/downloads \

docker run -d \
  --name=jackett \
  --network container:vpn \
  -e TZ=Europe/Paris \
  -e PUID=1000 \
  -e PGID=1000 \
  -e AUTO_UPDATE=true \
  -v /storage/.config/dockers/jackett:/config \
  --restart unless-stopped \
  --platform linux/arm64 \
  lscr.io/linuxserver/jackett:latest
