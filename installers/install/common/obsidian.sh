#! /bin/bash
# Works on Ubuntu/Debian systems

sudo apt-get install -y libgbm1 libasound2t64
deb_link=$(curl -s https://obsidian.md/download | grep -o "https://github.*/obsidian_.*_amd64.deb")
fpath=/tmp/obsidian_install.deb
wget -O $fpath $deb_link
sudo dpkg -D 1 -i $fpath
rm $fpath
