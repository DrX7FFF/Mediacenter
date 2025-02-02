#!/bin/bash

# # Dossier à analyser
# DIR="/media/HD1/Films"
# DISK="/dev/sda1"

# # Trouver tous les fichiers avec plusieurs hard links sur le disque
# # find / -xdev -type f -links +1 -exec ls -i {} + | sort -n | awk '
# find "$DISK" -type f -links +1 -exec ls -i {} + | sort -n | awk '
# {
#     inodes[$1] = inodes[$1] "\n" $2;
#     count[$1]++;
# }
# END {
#     for (inode in count) {
#         if (count[inode] > 1) {
#             print "Inode: " inode inodes[inode] "\n";
#         }
#     }
# }'


# Dossier à analyser
DISK="/var/media/HD1"  # Mets le bon chemin

# Trouver tous les fichiers avec plusieurs hard links
find "$DISK" -type f -links +1 -exec ls -li {} + | awk '
{
    inode = $1;
    $1=""; $2=""; $3=""; $4=""; $5=""; $6=""; $7=""; $8=""; # Supprime colonnes inutiles
    files[inode] = files[inode] "\n" $0;
    count[inode]++;
}
END {
    for (inode in count) {
        if (count[inode] > 1) {
            print "Inode: " inode files[inode] "\n";
        }
    }
}'
