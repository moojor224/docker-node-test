#!bin/bash

echo "executing gitea"
/usr/local/bin/gitea web --verbose --config /var/lib/gitea/app.ini > /var/lib/gitea/log/gitea-`date '+%F_%H:%M:%S'`.log