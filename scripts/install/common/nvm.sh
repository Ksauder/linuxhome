#!/bin/sh

user_shell git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
cd $HOME/.nvm && git checkout v0.40.1 && cd -
