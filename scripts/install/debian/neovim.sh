#!/bin/sh

echo "Installing Neovim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
echo "Done installing Neovim"

