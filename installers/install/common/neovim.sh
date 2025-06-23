#!/bin/sh

echo "Installing Neovim"
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
root_shell rm -rf /opt/nvim
root_shell tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >>~/.rc_bash_zsh.local
echo "Done installing Neovim"
