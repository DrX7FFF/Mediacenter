#!/bin/bash

# Dossier contenant les films
dossier_films="/media/HD1/Films"

# Boucle sur chaque fichier vidéo
for fichier in "$dossier_films"/*; do
    echo "Vérification de : $fichier"
    ffmpeg -v error -i "$fichier" -f null - 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "✅ OK"
    else
        echo "❌ Erreur dans $fichier"
    fi
done
