#!/bin/bash
# qbittorrent-prescript.sh

url="http://127.0.0.1:8080/v1/openvpn/portforwarded"
header="X-API-Key: 9jKwwjtzZYNVFk3nZZas8t"

# Vérification du disque
[[ -d "/data/Downloading" ]] || { echo "ERROR: No Drive mounted - Restart"; exit 1; }

# Vérification du port VPN
port=$(curl -sH "$header" "$url" | sed -n 's/.*"port":\([0-9]\+\).*/\1/p')
[[ -n "$port" && "$port" -ne 0 ]] || { echo "ERROR: No Port forwarded from VPN - Restart"; exit 1; }

echo "Port: $port"
echo "Mount: /data/Downloading found"

# Lance qbittorrent avec le port récupéré
exec /usr/bin/qbittorrent-nox --webui-port=8082 --torrenting-port="$port"
