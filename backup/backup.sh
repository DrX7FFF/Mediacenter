#! /bin/bash
DRY_RUN=""
if [[ "$1" == "dry" ]]; then
    DRY_RUN="--dry-run"
fi

rsync -av \
    --delete \
    --prune-empty-dirs \
    --exclude-from='config_exclude.txt' \
    $DRY_RUN \
    /storage/.config/ \
    /media/HD1/backup/config/

rsync -av \
    --delete \
    --prune-empty-dirs \
    --exclude-from='userdata_exclude.txt' \
    $DRY_RUN \
    /storage/.kodi/userdata/ \
    /media/HD1/backup/userdata/
