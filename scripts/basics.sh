#!/bin/sh
. $(realpath $(dirname $0)/.install_prep.sh) ${1}

echo "Installing basic apt packages"
install_packages \
    libpcap-dev \
    libncurses5 \
    ca-certificates \
    curl \
    fonts-font-awesome


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
    jq \
    gcc \
    make \
    pkg-config

run_install_script docker
run_install_script pyenv
run_install_script nvm
run_install_script poetry
run_install_script neovim

