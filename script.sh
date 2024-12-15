#!/bin/bash

cd /
# delete old backup
rm -rf /app_old
# make backup
mv /app /app_old
# delete old folder
rm -rf /app

#get new repo url
echo "Enter the url of a git repository: "
read REPO

# check if repo url is valid
git ls-remote "$REPO" > /dev/null 2>&1
if [ "$?" -ne 0 ]; then
    # display message
    echo "[ERROR] '$REPO' is not a valid git repository"
    # restore backup
    mv /app_old /app
    exit 1
else
    # clone repo
    git clone "$REPO" app
    # remove backup
    rm -rf /app_old
    # display message
    echo "Cloned repository to /app"
    exit 0
fi
