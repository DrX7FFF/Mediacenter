#!/bin/bash
VERSION="5"

appname="Mediacenter"
dockercomposeurl="https://github.com/docker/compose/releases/download/v2.33.0/docker-compose-linux-armv7"

tempfile="/tmp/myinstall.zip"
tempfolder="/tmp/myinstall"
toolsfolder="/storage/.kodi/tools"

echo "Installing $appname (setup version $VERSION)"

# Create tools folder
mkdir -p "$toolsfolder"

# Download and copy App
curl -L "https://github.com/DrX7FFF/$appname/archive/refs/heads/main.zip" -o "$tempfile"
unzip -o "$tempfile" -d "$tempfolder"
cp -rf "$tempfolder/$appname-main/." "$toolsfolder"
rm "$tempfile"
rm -r "$tempfolder"

# Download docker-compose
curl -L "$dockercomposeurl" -o "$toolsfolder/docker-compose"

# Make executable
chmod +x "$toolsfolder/docker-compose"
# chmod +x "$toolsfolder/backup.sh"
# chmod +x "$toolsfolder/restore.sh"
chmod +x "$toolsfolder/mediarenamer.py"
# chmod +x "$toolsfolder/status.sh"
# chmod +x "$toolsfolder/qbittorrent-prescript.sh"
chmod +x "$toolsfolder/*.sh"

cp -f "$toolsfolder/config/profile" "/storage/.profile"
