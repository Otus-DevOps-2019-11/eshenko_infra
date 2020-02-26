#!/bin/bash
set -e

cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

cat <<EOF> /etc/systemd/system/puma.service
[Unit]
Description=puma service
After=network.target
[Service]
Type=simple
WorkingDirectory=$HOME/reddit
ExecStart=/usr/local/bin/puma
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable puma.service
