#!/bin/bash

# https://wiki.servarr.com/radarr/custom-scripts

### ATTENTION les chemins sont en référentiel Docker Radarr
filmspath="/data/Films"
trashpath="/data/Servarr/Trash"
downloadpath="/data/Servarr/Downloads"
ticketpath="/data/Servarr/Tickets"
logfile="/data/Servarr/radarr_event.log"

## Création d'un ticket pour le rejouer sauf si on vient d'un ticket
echo ">>>>>> $(date) Begin" >> "$logfile"
if [[ -z "$ticketfile" ]]; then
    echo "[INFO] From Radarr call" >> "$logfile"
    
    moviename="${radarr_movie_title} (${radarr_movie_year})"
    downloadedfile="$1"
    ticketfile="$ticketpath/$moviename.txt"
    mkdir -p $ticketpath
    echo "moviename=\"$moviename\"" >> "$ticketfile"
    echo "downloadedfile=\"$downloadedfile\"" >> "$ticketfile"
    
    echo "[INFO] Ticket created \"$ticketfile\"" >> "$logfile"
else
    echo "[INFO] From ticket \"$ticketfile\"" >> "$logfile"
fi

echo "moviename=\"$moviename\"" >> "$logfile"
echo "downloadedfile=\"$downloadedfile\"" >> "$logfile"

# printenv >> "$logfile"

## Vérifier que le download est bien présent
if [[ ! -e "$downloadedfile" ]]; then
    echo "[ERROR] Abort download not found \"$downloadedfile\"" >> "$logfile"
    exit 1
fi

exit 0

## Déplacement du film dans la corbeille
if [[ -e "$actualfile" ]]; then
    mkdir -p "$trashpath"
    echo "[INFO] Trashing \"$actualfile\" to \"$trashpath\"" >> "$logfile"
    mv -f "$actualfile" "$trashpath"
    if [[ "$?" -ne 0 ]]; then 
        echo "[ERROR] Abort" >> "$logfile"
        exit 1
    fi
else
    echo "[INFO] No file to trash \"$actualfile\"" >> "$logfile"
fi

## Déplacement du film
destpath="$filmspath/$(basename "$downloadedfile")"
echo "[INFO] Moving : \"$downloadedfile\" to \"$destpath\"" >> "$logfile"
mv "$downloadedfile" "$destpath"
if [[ "$?" -ne 0 ]]; then
    echo "[ERROR] Abort" >> "$logfile"
    exit 1
fi

## Création du lien radarr (en référentiel docker Radarr)
echo "[INFO] Creating Radarr link of \"$destpath\" in \"$filmlinkpath\"" >> "$logfile"
mkdir -p "$filmlinkpath"
ln -s "$destpath" "$filmlinkpath"
if [[ "$?" -ne 0 ]]; then
    echo "[ERROR] Continue" >> "$logfile"
fi

## Vider dossier downloads
dirtemp=$(dirname "$downloadedfile")
if [[ "$dirtemp" != "$downloadpath" ]]; then
    # Enlever le dossier racine pour obtenir la chaîne des sous-dossiers
    subdirs=$(echo "$dirtemp" | sed "s|^$downloadpath/||")
    # Extraire le premier sous-dossier (B)
    first_subdir=$(echo "$subdirs" | cut -d'/' -f1)
    # Supprimer le dossier et tout son contenu
    echo "[INFO] Deleting \"$first_subdir\" de \"$downloadpath\"" >> "$logfile"
    rm -r "$downloadpath/$first_subdir"
fi

# ## Vider dossier trash
# for file in "${deleted_files[@]}"; do
#     echo "[INFO] Deleting \"$file\"" >> "$logfile"
#     rm -f "$file"
# done

## Arrivé au bout, supprimer le ticket
echo "[INFO] Remove Ticket \"$ticketfile\"" >> "$logfile"
rm -f "$ticketfile"
echo ">>>>>> $(date) End : $filmname" >> "$logfile"
