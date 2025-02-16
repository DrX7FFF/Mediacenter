# Mediacenter

## Installation
```
sh -c "$(curl -s https://raw.githubusercontent.com/DrX7FFF/Mediacenter/main/install.sh)"
```

## Download
```
mkdir -p /storage/.kodi/tools && \
cd /storage/.kodi/tools && \
curl -L -o temp.zip https://github.com/DrX7FFF/Mediacenter/archive/refs/heads/main.zip && \
unzip -o -q temp.zip && \
rm temp.zip
```

```
curl -L -o /storage/.kodi/temp/temp.zip https://github.com/DrX7FFF/Mediacenter/archive/refs/heads/main.zip && \
unzip -o -q /storage/.kodi/temp/temp.zip -d /storage/.kodi/userdata/tools && \
mv /storage/.kodi/userdata/tools/Mediacenter-main/* /storage/.kodi/userdata/tools/ && \
rmdir /storage/.kodi/userdata/tools/Mediacenter-main && \
rm /storage/.kodi/temp/temp.zip
```

app="Mediacenter" && \
curl -L -o /storage/.kodi/temp/temp.zip "https://github.com/DrX7FFF/$app/archive/refs/heads/main.zip" && \
unzip -o -q /storage/.kodi/temp/temp.zip -d /storage/.kodi/temp && \
cp -rf "/storage/.kodi/temp/$app-main/*" "/storage/.kodi/userdata/tools/$app" && \
rm /storage/.kodi/temp/temp.zip && \
rmdir -r "/storage/.kodi/temp/$app-main"



curl -L -o /storage/.kodi/tools/git https://github.com/tsari/git-static-builds/releases/download/latest/git-aarch64
chmod +x /storage/.kodi/tools/git


curl -L -o /storage/.kodi/userdata/tools/gh_arm64.tar.gz https://github.com/cli/cli/releases/download/v2.67.0/gh_2.67.0_linux_arm64.tar.gz

## Path
```
cd /storage/.kodi/tools
```
```
cd /storage/.kodi/userdata
```
```
cd /storage/.config/dockers
```

## docker compose release :
https://github.com/docker/compose/releases

```
curl -SL https://github.com/docker/compose/releases/download/v2.33.0/docker-compose-linux-armv7 -o docker-compose
chmod +x docker-compose
```

## Générateur de clés pour le site Gluetun
docker run --rm qmcgaw/gluetun genkey

## gh cli binary :
https://github.com/cli/cli/releases

## création du fichier .profile dans /storage :
```
export PATH="/storage/.kodi/tools:$PATH"
export COMPOSE_FILE="/storage/.kodi/tools/compose.yaml"
```
```
cp /storage/.kodi/tools/profile /storage/.profile
```
