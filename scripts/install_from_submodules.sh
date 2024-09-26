#!/bin/sh
SCRIPTDIR=$(dirname "$(realpath "$0")")

git submodule update --init --recursive

echo "Installing OMZ"
ln -s "$(realpath $SCRIPTDIR/../.oh-my-zsh)" ~/.oh-my-zsh
echo "OMZ installed"

echo "Installing tmux config"
ln -s "$(realpath $SCRIPTDIR/../.tmux/.tmux.conf)" ~/.tmux.conf
ln -s "$(realpath $SCRIPTDIR/../.tmux/.tmux.conf.local)" ~/.tmux.conf.local
echo "tmux config installed"
