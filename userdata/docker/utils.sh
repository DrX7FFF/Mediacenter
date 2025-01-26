url="192.168.1.102:8400"
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
