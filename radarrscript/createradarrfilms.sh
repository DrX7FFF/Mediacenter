#!/bin/bash

### ATTENTION les chemins sont en référentiel Docker Radarr
filmspath="/data/Films"
radarrpath="/data/Servarr/Films"

# Création du dossier Radarr si nécessaire
mkdir -p "$radarrpath"

# Parcourir chaque fichier dans le dossier source
find "$filmspath" -type f | while read -r film; do
  # Extraire le nom du fichier sans extension
  filmname=$(basename "${film%.*}")
  mkdir -p "$radarrpath/$filmname"

  # Créer un link dans le dossier dédié
  # ln "$film" "$radarrpath/$filmname/"
  ln -s "$film" "$radarrpath/$filmname/"
done
