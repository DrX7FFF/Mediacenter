#!/bin/bash

# Dossier source des films
INPUT_DIR="/home/moi/mediaHD1/Films"
# Dossier où Radarr accède
RADARR_DIR="/home/moi/mediaHD1/Servarr/Films"

# Création du dossier Radarr si nécessaire
# mkdir -p "$RADARR_DIR"

# Parcourir chaque fichier dans le dossier source
find "$INPUT_DIR" -type f | while read -r FILE; do
  # echo $FILE
  # Extraire le nom du fichier sans extension
  FILENAME=$(basename "${FILE%.*}")
  echo $FILENAME
  # Créer un dossier dédié
  mkdir -p "$RADARR_DIR/$FILENAME"
  # Créer un hard link dans le dossier dédié
  # ln "$FILE" "$RADARR_DIR/$FILENAME/"
  ln -s "$FILE" "$RADARR_DIR/$FILENAME/"
done
