#!/bin/sh

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

echo "Installing pyenv for ${USER}"
curl https://pyenv.run | bash
echo "Done installing pyenv"

pyenv install 3.12
pyenv global 3.12
python3 -m pip install --user pipx
python3 -m pipx ensurepath
