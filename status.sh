#! /bin/bash

echo "Public IP :"
curl -H 'X-API-Key: 9jKwwjtzZYNVFk3nZZas8t' 192.168.1.102:8080/v1/publicip/ip

echo "Port Forwarded :"
curl -H 'X-API-Key: 9jKwwjtzZYNVFk3nZZas8t' 192.168.1.102:8080/v1/openvpn/portforwarded

echo "DNS Status :"
curl -H 'X-API-Key: 9jKwwjtzZYNVFk3nZZas8t' 192.168.1.102:8080/v1/dns/status

# echo "Update Status :"
# curl http://192.168.1.102:8080/v1/updater/status

# curl http://192.168.1.102:8080/v1/openvpn/status
