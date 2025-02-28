#! /bin/bash
# restore.sh

DRY_RUN=""
if [[ "$1" == "dry" ]]; then
    DRY_RUN="--dry-run"
fi

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

rsync -av \
    --include-from="$SCRIPT_DIR/config/config_include.txt" \
    --exclude='*' \
    $DRY_RUN \
    /media/HD1/Backup/config/ \
    /storage/.config/

rsync -av \
    --include-from="$SCRIPT_DIR/config/userdata_include.txt" \
    --exclude='*' \
    $DRY_RUN \
    /media/HD1/Backup/userdata/ \
    /storage/.kodi/userdata/
