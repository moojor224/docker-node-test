#!/bin/bash

ls /bin

. ~/.bashrc

cd /app/js
npm i

service ssh start

npm run start