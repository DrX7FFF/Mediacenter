#! /bin/bash
rsync -av \
    --include-from='include.txt' \
    --exclude='*' \
    /media/HD1/_BackupKodi/ \
    /storage/.config/

# rsync -av \
#     --include-from='include.txt' \
#     --exclude='*' \
#     --dry-run \
#     /media/HD1/_BackupKodi/ \
#     /storage/.config/
