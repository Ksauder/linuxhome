#!/bin/sh
# currently only supports/tested on deb12

set -x

source_rc () {
    if [ $SHELL = "/bin/zsh" ]; then
        . ~/.zshrc
    elif [ $SHELL = "/bin/bash" ]; then
        . ~/.bashrc
    else
        echo "Not using zsh or bash, cannot source a matching rc file"
    fi
}

shell () {
    if command -v bash 2>%1 >/dev/null; then
        bash -c "$*"
    elif command -v zsh 2>%1 >/dev/null; then
        zsh -c "$*"
    else
        echo "Neither bash nor zsh has been found, cannot execute command"
        exit 1
    fi
}

# adding build deps here, but in the future they could be handled by the install script
# that actually needs them
sudo apt update

echo "Installing basic apt packages"
echo "APT - install deps"
sudo apt install -y \
    libpcap-dev \
    libncurses5 \
    ca-certificates \
    curl \
    fonts-font-awesome

echo "APT - install python3 build deps"
# https://devguide.python.org/getting-started/setup-building/index.html#install-dependencies
sudo apt install -y \
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

echo "APT - install tools"
sudo apt install -y \
    git \
    wget \
    htop \
    nmap \
    make \
    iftop \
    nethogs \
    zsh \
    bash \
    tmux

echo "Installing Neovim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
echo "Done installing Neovim"

echo "Installing docker"
# https://docs.docker.com/engine/install/debian/
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# allow user to use docker
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
echo "Done installing docker"

echo "Installing pyenv"
curl https://pyenv.run | bash
shell pyenv install 3.12
shell pyenv global 3.12
echo "Done installing pyenv"

git clone https://github.com/nvm-sh/nvm.git ~/.nvm
cd ~/.nvm && git checkout v0.40.1 && cd -

shell python3 -m pip install --user pipx
shell python3 -m pipx ensurepath

shell pipx install poetry
shell poetry completions bash >> ~/.bash_completion

