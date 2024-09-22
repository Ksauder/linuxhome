#!/bin/sh



echo "Installing OMZ"
ln -s ../.oh-my-zsh ~/.oh-my-zsh
# cp ../.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s $(which zsh)
echo "OMZ installed"

echo "Installing tmux config"
ln -s ../.tmux/.tmux.conf ~/.tmux.conf
ln -s ../.tmux/.tmux.conf.local ~/.tmux.conf.local
echo "tmux config installed"

