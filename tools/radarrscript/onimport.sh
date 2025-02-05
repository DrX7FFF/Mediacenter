#!/bin/bash
set -eu
# https://wiki.servarr.com/radarr/custom-scripts

### ATTENTION les chemins sont en référentiel Docker Radarr
filmspath="/data/Films"
radarrpath="/data/Servarr/Films"
trashpath="/data/Servarr/Trash"
downloadpath="/data/Servarr/Downloads"
ticketpath="/data/Servarr/Tickets"
logfile="/data/Servarr/radarr_event.log"

## Création d'un ticket pour le rejouer sauf si on vient d'un ticket
echo ">>>>>> $(date) Begin" >> "$logfile"
# echo "[DEBUG] radarr_movie_title=\""${radarr_movie_title:-}"\"" >> "$logfile"
# echo "[DEBUG] radarr_movie_year=\""${radarr_movie_year:-}"\"" >> "$logfile"
# echo "[DEBUG] @=\"$@\"" >> "$logfile"
# echo "[DEBUG] ticketfile=\"$ticketfile\"" >> "$logfile"
# printenv >> "$logfile"

if [[ -z "${ticketfile:-}" ]]; then
    echo "[INFO] From Radarr call" >> "$logfile"
    if [[ -z "${radarr_movie_title:-}" || -z "${radarr_movie_year:-}" ]]; then
        echo "[ERROR] Abort : missing movie title or year" >> "$logfile"
        exit 1
    fi
    moviename="${radarr_movie_title} (${radarr_movie_year})"
    downloadedfile="$1"
    ticketfile="$ticketpath/$moviename.txt"
    mkdir -p "$ticketpath"
    echo "moviename=\"$moviename\"" >> "$ticketfile"
    echo "downloadedfile=\"$downloadedfile\"" >> "$ticketfile"
    
    echo "[INFO] Ticket created \"$ticketfile\"" >> "$logfile"
else
    echo "[INFO] From ticket \"$ticketfile\"" >> "$logfile"
fi

[[ -n "${moviename:-}" ]] || { echo "[ERROR] Abort : \"moviename\" not definned" >> "$logfile"; exit 1; }
[[ -n "${downloadedfile:-}" ]] || { echo "[ERROR] Abort : \"downloadedfile\" not definned" >> "$logfile"; exit 1; }

echo "moviename=\"$moviename\"" >> "$logfile"
echo "downloadedfile=\"$downloadedfile\"" >> "$logfile"

## Vérifier que le download est bien présent
[[ -e "$downloadedfile" ]] || { echo "[ERROR] Abort download not found \"$downloadedfile\"" >> "$logfile"; exit 1; }


## Déplacement du film dans la corbeille
trashfiles="$filmspath/$moviename"
mkdir -p "$trashpath"
echo "[INFO] Trashing \"$trashfiles\".* to \"$trashpath/\"" >> "$logfile"
shopt -s nullglob
for file in "$trashfiles".*; do
    echo "[INFO] Trashing \"$file\" to \"$trashpath/\"" >> "$logfile"
    [[ -e "$file" ]] && mv -f "$file" "$trashpath/" || { echo "[ERROR] Abort" >> "$logfile"; exit 1; }
done
shopt -u nullglob  # Désactive nullglob après usage

## Déplacement du film
[[ "$downloadedfile" == *.* ]] && extension="${downloadedfile##*.}" || extension=""
destfile="$filmspath/$moviename.$extension"
echo "[INFO] Moving : \"$downloadedfile\" to \"$destfile\"" >> "$logfile"
mv -f "$downloadedfile" "$destfile" || { echo "[ERROR] Abort" >> "$logfile"; exit 1; }


## Création du lien radarr (en référentiel docker Radarr)
filmlinkpath="$radarrpath/$moviename"
echo "[INFO] Creating Radarr link of \"$destfile\" in \"$filmlinkpath\"" >> "$logfile"
mkdir -p "$filmlinkpath"
ln -s "$destfile" "$filmlinkpath" || echo "[ERROR] Continue" >> "$logfile"


## Vider dossier downloads
dirtemp=$(dirname "$downloadedfile")
if [[ "$dirtemp" != "$downloadpath" ]]; then
    # Enlever le dossier racine pour obtenir la chaîne des sous-dossiers
    # Extraire le premier sous-dossier (B)
    first_subdir=$(echo "$dirtemp" | sed "s|^$downloadpath/||" | cut -d'/' -f1)
    # Supprimer le dossier et tout son contenu
    echo "[INFO] Deleting \"$first_subdir\" de \"$downloadpath\"" >> "$logfile"
    rm -rf "$downloadpath/$first_subdir"
fi

## Arrivé au bout, supprimer le ticket
echo "[INFO] Remove Ticket \"$ticketfile\"" >> "$logfile"
[[ -f "$ticketfile" ]] && rm -f "$ticketfile"
echo ">>>>>> $(date) End : $moviename" >> "$logfile"
