#!/bin/bash
apt update
apt upgrade -y

apt install -y docker.io docker-compose
systemctl enable docker-compose
systemctl start docker-compose

ufw allow OpenSSH
# Add any firewall rules you need
# for your application here
ufw allow 30000/udp
ufw --force enable
