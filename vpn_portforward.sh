#!/bin/bash
#!/bin/sh
# vpn_portforward.sh

# === PARAMÈTRES ===
PORT="$1"
TRIES="${2:-10}"
WAIT="${3:-5}"
QBIT_URL="http://localhost:8082"

# === DÉTERMINER LE DOSSIER DU SCRIPT ===
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="$SCRIPT_DIR/vpn_portforward.log"

# === FONCTION LOG ===
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# === VALIDATION ===
if [ -z "$PORT" ]; then
    echo "Usage: $0 <port> [tries] [wait]"
    exit 1
fi

# === APPEL API qBittorrent ===
log "Setting qBittorrent listening port to $PORT (tries=$TRIES, wait=${WAIT}s)"

wget --retry-connrefused --tries="$TRIES" --wait="$WAIT" \
     --header="Content-Type: application/x-www-form-urlencoded" \
     --post-data "json={\"listen_port\":$PORT}" \
     -qO- "$QBIT_URL/api/v2/app/setPreferences" >> "$LOG_FILE" 2>&1
