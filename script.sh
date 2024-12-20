echo "add git user"
adduser --system --shell /bin/bash --gecos 'Git Version Control' --group --disabled-password --home /home/git git

mv /start_gitea.sh /home/git/start_gitea.sh
chown git:git /home/git/start_gitea.sh

echo "make gitea folders"
mkdir -p /var/lib/gitea/custom
mkdir -p /var/lib/gitea/data
mkdir -p /var/lib/gitea/log
chown -R git:git /var/lib/gitea/
chmod -R 750 /var/lib/gitea/

mkdir /etc/gitea
chown root:git /etc/gitea
chmod 770 /etc/gitea

echo "move gitea executable"
cp gitea /usr/local/bin/gitea

echo "chown various things"
chown git:git /etc/systemd/system/gitea.service
chown git:git /usr/local/bin/gitea
chown git:git /home/git/start_gitea.sh
chown git:git /etc/gitea
chown -R git:git /var/lib/gitea/

echo "chmod various things"
chmod +x /usr/local/bin/gitea
chmod +x /home/git/start_gitea.sh
chmod 750 /etc/gitea

mkdir -p /etc/sudoers.d
echo "git ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/git

echo "start service"
systemctl enable gitea
systemctl start gitea

echo "done"