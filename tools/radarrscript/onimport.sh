#!/bin/bash

# https://wiki.servarr.com/radarr/custom-scripts

### ATTENTION les chemins sont en référentiel Docker Radarr
filmspath="/data/Films"
trashpath="/data/Servarr/Trash"
downloadpath="/data/Servarr/Downloads"
logfile="/data/Servarr/radarr_event.log"

filmname="${radarr_movie_title} (${radarr_movie_year})"
echo ">>>>>> $(date) Begin : $filmname" >> "$logfile"

downloadedfile="$1"
actualfilelink="$2"
actualfile="$filmspath/$(basename "$radarr_deletedpaths")"
echo "downloadedfile=\"$downloadedfile\"" >> "$logfile"
echo "actualfilelink=\"$actualfilelink\"" >> "$logfile"
echo "radarr_deletedpaths=\"$radarr_deletedpaths\"" >> "$logfile"
echo "actualfile=\"$actualfile\"" >> "$logfile"

## Création d'un ticket pour le rejouer sauf si on vient d'un ticket
if [[ -z "$ticketfile" ]]; then
    ticketpath="/data/Servarr/Tickets"
    mkdir -p $ticketpath
    ticketfile="$ticketpath/$filmname.txt"
    echo "radarr_movie_title=\"${radarr_movie_title}\"" >> "$ticketfile"
    echo "radarr_movie_year=\"${radarr_movie_year}\"" >> "$ticketfile"
    echo "downloadedfile=\"$downloadedfile\"" >> "$ticketfile"
    echo "actualfilelink=\"$actualfilelink\"" >> "$ticketfile"
else
    echo "[INFO] Ticket already exists \"$ticketfile\"" >> "$logfile"
fi

# printenv >> "$logfile"

## Vérifier que le download est bien présent
if [[ ! -e "$downloadedfile" ]]; then
    echo "[ERROR] Abort download not found \"$downloadedfile\"" >> "$logfile"
    exit 1
fi

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
filmlinkpath=$(dirname "$actualfilelink")
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
rm -f "$ticketfile"
echo ">>>>>> $(date) End : $filmname" >> "$logfile"
