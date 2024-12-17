#!/bin/sh

. ~/.bashrc

mkdir -p /var/lib/gitea/{custom,data,log}
chown -R git:git /var/lib/gitea/

systemctl start gitea
systemctl enable gitea

cd /app/js
npm i
npm run start