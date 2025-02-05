#!/bin/bash

# https://wiki.servarr.com/radarr/custom-scripts

### ATTENTION les chemins sont en référentiel Docker Radarr
filmspath="/data/Films"
radarrpath="/data/Servarr/Films"
trashpath="/data/Servarr/Trash"
downloadpath="/data/Servarr/Downloads"
logfile="/data/Servarr/radarr_event.log"

if [[ "$radarr_eventtype" == "Test" ]]; then
    filmname="Fake Movie (9999)"
    # filmname="Armageddon (1998)"
    # radarr_moviefile_sourcepath="/data/Servarr/Downloads/Armageddon.1998.Eng.Fre.Ger.Ita.Spa.Cze.Hun.Pol.Rus.1080p.BluRay.Remux.AVC.DTS-HD.MA-SGF.mkv"
else
    filmname="${radarr_movie_title} (${radarr_movie_year})"
fi

echo ">>>>>> $(date) : Begin $filmname" >> "$logfile"

## Création d'un ticket pour le rejouer sauf si on vient d'un ticket
if [[ -n "$ticketfile" ]]; then
    ticketpath="/data/Servarr/Tickets"
    mkdir -p $ticketpath
    ticketfile="$ticketpath/$filmname.txt"
    echo "radarr_eventtype=\"${radarr_eventtype}\"" >> "$ticketfile"
    echo "radarr_movie_title=\"${radarr_movie_title}\"" >> "$ticketfile"
    echo "radarr_movie_year=\"${radarr_movie_year}\"" >> "$ticketfile"
    echo "radarr_moviefile_sourcepath=\"${radarr_moviefile_sourcepath}\"" >> "$ticketfile"
    echo "radarr_moviefile_sourcefolder=\"${radarr_moviefile_sourcefolder}\"" >> "$ticketfile"
    echo "radarr_isupgrade=\"${radarr_isupgrade}\"" >> "$ticketfile"
    echo "radarr_moviefile_quality=\"${radarr_moviefile_quality}\"" >> "$ticketfile"
    echo "radarr_deletedpaths=\"${radarr_deletedpaths}\"" >> "$ticketfile"
else
    echo "[INFO] Ticket already exists" >> "$logfile"
fi

echo "radarr_sourcepath=\"${radarr_sourcepath}\"" >> "$logfile"


echo "Arguments : $@" >> "$logfile"
printenv >> "$logfile"



echo "base_dir=\"${base_dir}\"" >> "$logfile"
echo "radarr_eventtype=\"${radarr_eventtype}\"" >> "$logfile"
echo "radarr_movie_title=\"${radarr_movie_title}\"" >> "$logfile"
echo "radarr_movie_year=\"${radarr_movie_year}\"" >> "$logfile"
echo "radarr_moviefile_sourcepath=\"${radarr_moviefile_sourcepath}\"" >> "$logfile"
echo "radarr_moviefile_sourcefolder=\"${radarr_moviefile_sourcefolder}\"" >> "$logfile"
echo "radarr_moviefile_relativepath=\"${radarr_moviefile_relativepath}\"" >> "$logfile"
echo "radarr_moviefile_path=\"${radarr_moviefile_path}\"" >> "$logfile"
echo "radarr_deletedrelativepaths=\"${radarr_deletedrelativepaths}\"" >> "$logfile"
echo "radarr_deletedpaths=\"${radarr_deletedpaths}\"" >> "$logfile"
echo "radarr_isupgrade=\"${radarr_isupgrade}\"" >> "$logfile"
echo "radarr_moviefile_quality=\"${radarr_moviefile_quality}\"" >> "$logfile"

## Vérifier que le download est bien présent
if [[ ! -e "$radarr_sourcepath" ]]; then
    echo "[ERROR] Abort download not found \"$radarr_sourcepath\"" >> "$logfile"
    exit 1
fi

## Supression du ou des films existants
mkdir -p "$trashpath"
count=0
declare -a deleted_files
while read -r trashfile; do
    ((count++))
    echo "[INFO] Moving \"$trashfile\" to \"$trashpath\"" >> "$logfile"
    mv "$trashfile" "$trashpath"
    if [[ "$?" -ne 0 ]]; then 
        echo "[ERROR] Abort" >> "$logfile"
        exit 1
    fi
    deleted_files+=("$trashpath/$(basename "$trashfile")")
done < <(find "$filmspath" -name "$filmname.*" -type f)
if [[ $count -gt 1 ]]; then echo "[WARN] Cleaning $count files"; fi

## Supression des liens radarr
filmlinkpath="$radarrpath/$filmname"
echo "[INFO] Cleaning Radarr link in \"$filmlinkpath\"" >> "$logfile"
find "$filmlinkpath" -mindepth 1 -delete

## Déplacement du film
# extension="${radarr_moviefile_sourcepath##*.}"
# if [[ "$radarr_moviefile_sourcepath" == "$extension" ]]; then extension=""; fi
# destpath="$filmspath/$filmname.$extension"
destpath="$filmspath/$(basename "$radarr_moviefile_sourcepath")"
echo "[INFO] Moving : \"$radarr_moviefile_sourcepath\" to \"$destpath\"" >> "$logfile"
mv "$radarr_moviefile_sourcepath" "$destpath"
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
if [[ "$radarr_moviefile_sourcefolder" != "$downloadpath" ]]; then
    echo "[INFO] Deleting \"$radarr_moviefile_sourcefolder\"" >> "$logfile"
    rm -r "$radarr_moviefile_sourcefolder"
fi

## Vider dossier trash
for file in "${deleted_files[@]}"; do
    echo "[INFO] Deleting \"$file\"" >> "$logfile"
    rm -f "$file"
done

## Arrivé au bout, supprimer le ticket
rm -f "$ticketfile"
echo ">>>>>> $(date) : End $filmname" >> "$logfile"
