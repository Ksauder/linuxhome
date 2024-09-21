#!/bin/sh

echo "Installing OMZ from submodule"
ln -s ../.oh-my-zsh ~/.oh-my-zsh
# cp ../.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s $(which zsh)
echo "OMZ installed"
