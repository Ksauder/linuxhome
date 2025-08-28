#!/bin/bash

if [ ! -f /etc/apt/sources.list.d/hashicorp.list ]; then
    install_packages gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg |
        gpg --dearmor |
        root_shell tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null

    gpg --no-default-keyring \
        --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
        --fingerprint

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
        root_shell tee /etc/apt/sources.list.d/hashicorp.list
else
    echo "Found /etc/apt/sources.list.d/hashicorp.list - hashicorp repo already installed"
fi
