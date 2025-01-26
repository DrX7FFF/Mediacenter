#!/bin/bash

# Répertoire à scanner
repertoire="./dossier_a_scanner"

# Vérifie si le répertoire existe
if [ ! -d "$repertoire" ]; then
  echo "Le dossier $repertoire n'existe pas."
  exit 1
fi

# Parcours les fichiers du répertoire
for fichier in "$repertoire"/*; do
  # Vérifie si c'est un fichier
  if [ -f "$fichier" ]; then
    # Récupère le nom de fichier sans l'extension
    nom_fichier=$(basename "$fichier")
    nom_sans_extension="${nom_fichier%.*}"
    
    # Crée un dossier avec le nom sans extension
    nouveau_dossier="$repertoire/$nom_sans_extension"
    mkdir -p "$nouveau_dossier"
    
    # Déplace le fichier dans ce dossier
    mv "$fichier" "$nouveau_dossier/"
    echo "Déplacé : $fichier -> $nouveau_dossier/"
  fi
done
