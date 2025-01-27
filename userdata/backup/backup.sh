#! /bin/bash
rsync -av \
    --delete \
    --prune-empty-dirs \
    --exclude-from='exclude.txt' \
    /storage/.config/ \
    /media/HD1/_BackupKodi/


# rsync -av \
#     --delete \
#     --prune-empty-dirs \
#     --exclude-from='exclude.txt' \
#     --dry-run \
#     /storage/.config/ \
#     /media/HD1/_BackupKodi/
