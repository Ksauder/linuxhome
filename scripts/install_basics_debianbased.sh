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
    curl \
    wget \
    htop \
    nmap \
    make \
    iftop \
    nethogs \
    neovim

curl https://pyenv.run | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

python3 -m pip install --user pipx
python3 -m pipx ensurepath

pipx install poetry
poetry completions bash >> ~/.bash_completion

