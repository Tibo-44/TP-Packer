#!/usr/bin/env bash
echo Installation de Go-Lang
yum install git golang -y
git clone https://github.com/BastienBalaud/golang-myip.git
cd /root/tp-1/golang-myip
go build server.go
cp server /usr/local/bin/
cd /etc/systemd/system/
echo "
[Unit]
Description=Run myip as Service
ConditionPathExists=/root/tp-1/golang-myip
After=network.target

[Service]
Type=simple
User=root
Group=root

WorkingDirectory=/root/tp-1/golang-myip/
ExecStart=/usr/local/bin/server
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
" > myip.service
systemctl enable myip.service
systemctl start myip.service
echo "FIN"
