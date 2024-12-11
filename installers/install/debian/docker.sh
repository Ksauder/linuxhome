#!/bin/sh

remove_packages docker.io docker-doc docker-compose podman-docker containerd runc
install -m 0755 -d /etc/apt/keyrings
root_shell curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
root_shell chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    root_shell tee /etc/apt/sources.list.d/docker.list >/dev/null
install_packages docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# allow user to use docker
root_shell groupadd docker || true
root_shell usermod -aG docker $USER
root_shell systemctl enable docker.service
root_shell systemctl enable containerd.service
