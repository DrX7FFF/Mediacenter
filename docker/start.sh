#! /bin/bash

source utils.sh

./gluetun.sh
echo "Attente DNS"
DNS=$(check_DNS)
if [ $? -eq 0 ]; then
  echo "DNS : $DNS"
else
  echo "Erreur : $DNS"
  exit 1
fi

./qbittorrent.sh
# ./jackett.sh
./flaresolverr.sh
./prowlarr.sh
./radarr.sh
# ./sonarr.sh
# ./pyload.sh