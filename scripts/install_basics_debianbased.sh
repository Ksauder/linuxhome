#!/bin/sh

# adding build deps here, but in the future they could be handled by the install script
# that actually needs them
apt update
echo "Installing basic apt packages"
echo "APT - install deps"
apt install -y \
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

python3 -m pip install --user pipx
python3 -m pipx ensurepath
