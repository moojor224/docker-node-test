#!/bin/sh

. ~/.bashrc

systemctl start gitea
systemctl enable gitea

cd /app/js
npm i
npm run start