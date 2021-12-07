#!/usr/bin/env bash

# Installation de golang-myip

echo Installation de golang-myip
yum install git golang -y
git clone https://github.com/BastienBalaud/golang-myip.git
cd /root/golang-myip

# Build du server.go
go build server.go

# Déplacement dans le répertoire des binaires
cp server /usr/local/bin/

# Création du service golang
cd /etc/systemd/system/
echo "
[Unit]
Description=Run golang as service
ConditionPathExists=/root/golang-myip
After=network.target

[Service]
Type=simple
User=root
Group=root

WorkingDirectory=/root/golang-myip/
# Rendre accessible goland sur le port 80
ExecStart=/usr/local/bin/server --port 80
Restart=on-failure
RestartSec=10


[Install]
WantedBy=multi-user.target
" > golang.service

# Démarrage du service golang
systemctl enable golang.service
systemctl start golang.service

# Ajout des clés SSH
cd /root/.ssh
echo"
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILjIRqNf3oVs8vbAcoNHzXMxlS5fL6qqFxfdi221S9p6
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmM7WeoXFKZGnDLV8RA3jfeYKPIYzTNIe3Yqr7Z11BV
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJXNu2wW1ssMqlzRd3q/YodypM77UNFz7tF6h2v+hYYZ
" >> authorized_keys

echo "FIN SCRIPT LAUNCH-VM"
sleep 200
