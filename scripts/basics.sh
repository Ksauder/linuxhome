#!/bin/sh
. ./.install_prep.sh

echo "Installing basic apt packages"
install_packages \
    libpcap-dev \
    libncurses5 \
    ca-certificates \
    curl \
    fonts-font-awesome

echo "Install python3 build deps"
# https://devguide.python.org/getting-started/setup-building/index.html#install-dependencies
install_packages \
    build-essential \
    gdb \
    lcov \
    pkg-config \
    libbz2-dev \
    libffi-dev \
    libgdbm-dev \
    libgdbm-compat-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    lzma \
    lzma-dev \
    tk-dev \
    uuid-dev \
    zlib1g-dev

# libmpdec-dev # only available for deb <12 and ubuntu <24

echo "Install tools"
install_packages \
    git \
    wget \
    htop \
    nmap \
    make \
    iftop \
    nethogs \
    zsh \
    bash \
    tmux \
    jq

#echo "Installing Neovim"
#curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
#rm -rf /opt/nvim
#tar -C /opt -xzf nvim-linux64.tar.gz
#rm nvim-linux64.tar.gz
#echo "Done installing Neovim"
#
##echo "Installing docker"
##echo "Done installing docker"
#
#
#
#
