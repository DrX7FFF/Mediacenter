#! /bin/bash
DRY_RUN=""
if [[ "$1" == "dry" ]]; then
    DRY_RUN="--dry-run"
fi

rsync -av \
    --include-from='config_include.txt' \
    --exclude='*' \
    $DRY_RUN \
    /media/HD1/backup/config/ \
    /storage/.config/

rsync -av \
    --include-from='userdata_include.txt' \
    --exclude='*' \
    $DRY_RUN \
    /media/HD1/backup/userdata/ \
    /storage/.kodi/userdata/
