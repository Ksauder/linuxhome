#!/bin/sh

echo "Installing basic apt packages"
install_packages \
    libpcap-dev \
    libncurses6 \
    ca-certificates \
    curl \
    fonts-font-awesome \
    snapd

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
    pkg-config \
    npm

run_install_script docker
run_install_script pyenv
run_install_script nvm
run_install_script poetry
run_install_script neovim
run_install_script git-completions
