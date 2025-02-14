#! /bin/bash


if [ -z "$1" ]; then
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/pyload"; then 
        docker stop pyload
        docker rm pyload
    fi
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/jackett"; then 
        docker stop jackett
        docker rm jackett
    fi
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/radarr"; then 
        docker stop radarr
        docker rm radarr
    fi
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/sonarr"; then 
        docker stop sonarr
        docker rm sonarr
    fi
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/prowlarr"; then 
        docker stop prowlarr
        docker rm prowlarr
    fi
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/qbittorrent"; then 
        docker stop qbittorrent
        docker rm qbittorrent
    fi
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/portcheck"; then 
        docker stop portcheck
        docker rm portcheck
    fi
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/flaresolverr"; then 
        docker stop flaresolverr
        docker rm flaresolverr
    fi
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/vpn"; then 
        docker stop vpn
        docker rm vpn
    fi
else
    if docker inspect -f '{{.Name}}' $(docker ps -aq) | grep -q "/$1"; then 
        docker stop "$1"
        docker rm "$1"
    else
        echo "$1 n'existe pas"
    fi
fi
