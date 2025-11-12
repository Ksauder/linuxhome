#!/bin/sh

set -e

echo "Installing Neovim"
curl -LO --fail-with-body https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzvsf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
ln -fs /opt/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim
#echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.rc_bash_zsh.local
echo "Done installing Neovim"

