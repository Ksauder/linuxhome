#!/bin/bash

if [ ! -f ~/.config/rclone/rclone.conf ]; then
    echo "Do rclone config for onedrive first"
    exit 1
fi

# do rclone stuff
USER_HOMEDIR=/home/ksauder@kdsbunker.com
RCLONE_REMOTE=onedrive
cat <<EOF >/etc/systemd/system/rclone-onedrive.service
[Unit]
Description=Rclone onedrive
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/bin/rclone mount --vfs-cache-mode writes ${RCLONE_REMOTE}:/ ${USER_HOMEDIR}/onedrive
User=${USER}

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now rclone-onedrive

# links
mkdir ~/library_backups

mv ~/Documents ~/library_backups/
mv ~/Pictures ~/library_backups/
mv ~/Videos ~/library_backups/
mv ~/Music ~/library_backups/

ln -s ~/onedrive/Documents ~/Documents
ln -s ~/onedrive/Pictures ~/Pictures
ln -s ~/onedrive/Videos ~/Videos
ln -s ~/onedrive/Music ~/Music
