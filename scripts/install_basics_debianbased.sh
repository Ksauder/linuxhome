#!/bin/sh

# adding build deps here, but in the future they could be handled by the install script
# that actually needs them
apt update
echo "Installing basic apt packages"
echo "APT - install deps"
apt install -y \
    libssl-dev \
    build-essential \
    libncurses5-dev \
    libpcap-dev \
    libncurses5
echo "APT - install tools"
apt install -y \
    git \
    curl \
    wget \
    htop \
    nmap \
    make \
    iftop \
    nethogs \
    neovim

curl https://pyenv.run | bash

git clone https://github.com/nvm-sh/nvm.git ~/.nvm
pushd ~/.nvm && git checkout v0.40.1 && popd 

python3 -m pip install --user pipx
python3 -m pipx ensurepath

pipx install poetry
poetry completions bash >> ~/.bash_completion

