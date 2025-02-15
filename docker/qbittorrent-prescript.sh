#!/bin/bash
# qbittorrent-prescript.sh

url="127.0.0.1:8080"
urlIP="/v1/publicip/ip"
urlDNS="/v1/dns/status"
urlPort="/v1/openvpn/portforwarded"
header="X-API-Key: 9jKwwjtzZYNVFk3nZZas8t"

check_with_retry() {
    local endpoint="$1"       # Endpoint spécifique
    local parser="$2"         # Commande pour extraire la donnée
    local condition="$3"      # Condition personnalisée
    local max_retries=30       # Nombre maximum de tentatives
    local counter=0

    while [[ $counter -lt $max_retries ]]; do
        result=$(curl -sH "$header" "$url$endpoint" | eval "$parser")

        if eval "$condition"; then
            echo "$result"  # Retourne le résultat en sortie standard
            return 0
        fi
        counter=$((counter + 1))
        sleep 2
    done

    echo " Timeout"
    return 1
}

# Fonction spécifique pour vérifier le DNS
check_DNS() {
    check_with_retry \
        "$urlDNS" \
        'sed -n "s/.*\"status\":\"\([^\"]\+\)\".*/\1/p"' \
        '[[ "$result" == "running" ]]'
}

# Fonction spécifique pour vérifier le Port
check_Port() {
    check_with_retry \
        "$urlPort" \
        'sed -n "s/.*\"port\":\([0-9]\+\).*/\1/p"' \
        '[[ -n "$result" && $result -ne 0 ]]'
}

check_mount() {
    echo "checkmount ..."
    if [ -d "/data/Downloading" ]; then
        echo "Disk mounted with folder 'Downloading'"
        return 0
    fi

    echo " Timeout"
    return 1
}

port=$(check_Port)
if [ $? -eq 0 ]; then
  echo "Port : $port"
else
  echo "ERROR : No Portforwarded form VPN"
  exit 1
fi

check_mount
if [ $? -eq 0 ]; then
  echo "Drive mounted"
else
  echo "ERROR : No Drive mounted"
  exit 1
fi

# Lance qbittorrent avec le port récupéré
exec /usr/bin/qbittorrent-nox --webui-port=8082 --torrenting-port=$port
