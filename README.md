# Mediacenter

## Installation
```
sh -c "$(curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/DrX7FFF/Mediacenter/main/install.sh)"
```

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

## Cmd
```
docker-compose down && docker-compose up -d
docker-compose down
docker-compose up -d
docker system prune -a -f
docker logs -f vpn
status.sh
docker exec -it vpn sh
docker exec -it qbittorrent sh
docker exec -it mkvtoolnix sh
```
chmod -R 777 /var/media/HD1 && chown -R nobody:nogroup /var/media/HD1
```

## docker compose release :
https://github.com/docker/compose/releases

## gh cli binary :
https://github.com/cli/cli/releases
```
curl -L -o /storage/.kodi/userdata/tools/gh_arm64.tar.gz https://github.com/cli/cli/releases/download/v2.67.0/gh_2.67.0_linux_arm64.tar.gz
```

## Générateur de clés pour le site Gluetun
```
docker run --rm qmcgaw/gluetun genkey
```

