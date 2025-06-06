#! /bin/bash
# backup.sh

DRY_RUN=""
if [[ "$1" == "dry" ]]; then
    DRY_RUN="--dry-run"
else
    mkdir -p "/media/HD1/Backup"
fi

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

rsync -av \
    --delete \
    --prune-empty-dirs \
    --exclude-from="$SCRIPT_DIR/config/config_exclude.txt" \
    $DRY_RUN \
    /storage/.config/ \
    /media/HD1/Backup/config/

rsync -av \
    --delete \
    --prune-empty-dirs \
    --exclude-from="$SCRIPT_DIR/config/userdata_exclude.txt" \
    $DRY_RUN \
    /storage/.kodi/userdata/ \
    /media/HD1/Backup/userdata/
