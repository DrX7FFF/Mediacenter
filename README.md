# Mediacenter


## Download
```
mkdir -p /storage/.kodi/userdata/tools && \
cd /storage/.kodi/userdata/tools && \
curl -L -o temp.zip https://github.com/DrX7FFF/Mediacenter/archive/refs/heads/main.zip && \
unzip -o -j -q temp.zip && \
rm temp.zip
```

## Chemins
cd ~/.kodi/userdata/tools
cd /storage/.kodi/userdata

## Docker path :
cd ~/.config/dockers

## Générateur de clés pour le site Gluetun
docker run --rm qmcgaw/gluetun genkey
