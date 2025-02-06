#!/bin/bash

# https://docs.tdarr.io/docs/installation/docker/run-compose
    # --log-opt max-size=10m \
    # --log-opt max-file=5 \
# /dev/mali0
    # --device=/dev/dri:/dev/dri \
    # --gpus=all \
    # -e "internalNode=true" \

docker run -ti \
    -v /storage/.config/dockers/tdarr/server:/app/server \
    -v /storage/.config/dockers/tdarr/configs:/app/configs \
    -v /storage/.config/dockers/tdarr/logs:/app/logs \
    -v /media/HD1:/media \
    -v /storage/.config/dockers/tdarr/transcode_cache:/temp \
    -e "serverIP=0.0.0.0" \
    -e "serverPort=8266" \
    -e "webUIPort=8265" \
    -e "internalNode=false" \
    -e "inContainer=true" \
    -e "ffmpegVersion=6" \
    -e "nodeName=MyInternalNode" \
    --network bridge \
    -p 8265:8265 \
    -p 8266:8266 \
    -e "TZ=Europe/Paris" \
    -e PUID=1000 \
    -e PGID=1000 \
    -e "NVIDIA_DRIVER_CAPABILITIES=all" \
    -e "NVIDIA_VISIBLE_DEVICES=all" \
    --platform linux/arm64 \
    ghcr.io/haveagitgat/tdarr