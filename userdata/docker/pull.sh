#!/bin/bash

# Mettre à jour les images des containers démarrés avec la plateforme correcte
docker ps --format '{{.Image}}' | sort | uniq | while read image; do
  platform=$(docker inspect --format '{{.Os}}/{{.Architecture}}' "$image")
  docker pull --platform "$platform" "$image"
done
