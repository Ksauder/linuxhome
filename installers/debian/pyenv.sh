#!/bin/sh

# FIXME: should install scripts be run from a user context? how should my shell functions work then

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

echo "Installing pyenv for ${SUDO_USER}"
curl https://pyenv.run | bash
# FIXME: breaks here, I tihnk I need to eval the pyenv init manually here
pyenv install 3.12
pyenv global 3.12
echo "Done installing pyenv"

python3 -m pip install --user pipx
python3 -m pipx ensurepath
