set tempdir := "/tmp"

DISTROS := "debian11 debian12 ubuntu20 ubuntu22 ubuntu24"
DOCKER_PREFIX := "homrepo_"
DRY_RUN := env("DRY_RUN", '0')
export REPO_ROOT := justfile_directory()
export BACKUP_DIR := "~/.dotfilebackups"
export INSTALLERS_DIR := justfile_directory() + "/installers"
export TEST_DIR := justfile_directory() + "/tests"
export PYTHONPATH := REPO_ROOT + "/lib/python"

root_shell := """sudo su root -c \"/bin/bash -c '$*'\""""

load_utils := ". " + REPO_ROOT + "/lib/sh/basic_utils_lib.sh"


debug:
    #!/usr/bin/env bash
    echo "{{ load_utils }}"
    echo '{{ root_shell }}'
    echo '{{ REPO_ROOT }}'

install *packages:
    #!/usr/bin/env python3
    import sys
    sys.path.insert(0, "{{ REPO_ROOT }}/lib/python")
    from install_mgr import Installer
    pkgs = "{{packages}}".split(' ')
    dry_run = bool(int("{{ DRY_RUN }}"))
    installer = Installer(pkgs, dry_run=dry_run)

bootstrap_stow:
    stow --dotfiles -d dotfiles -t ~/ git kitty tmux vim nvim zsh

unbootstrap_stow:
    stow --dotfiles -D -d dotfiles -t ~/ git kitty tmux vim nvim zsh

#TODO: finish converting this using justfile and/or python
bootstrap:
    #!/bin/bash
    # required vars
    # REPO_ROOT=$(dirname "$(realpath "$0")")
    # BACKUP_DIR="${HOME}/.dotfilebackups"
    # HOME
    CONFIG_BACKUP_DIR="${BACKUP_DIR}/config_backup"
    # init any submodules and run any machine setup scripts
    echo "Linking dotfiles"
    mkdir -p ${BACKUP_DIR}
    mkdir -p ${CONFIG_BACKUP_DIR}
    for file in $(find ${REPO_ROOT}/dotfiles -maxdepth 1 -type f,l); do
        filename=$(basename "${file}")
        if [ -f "${HOME}/${filename}" ] && [ ! -L "${HOME}/${filename}" ]; then
            # FIXME: what if the existing node isn't a file, but instead a symlink?
            mv "$HOME/${filename}" "${BACKUP_DIR}/${filename}.orig.bak"
        fi
        if [ ! -L "${HOME}/${filename}" ]; then
            echo "- ${HOME}/${filename} -> ${file}"
            ln -s "$(realpath ${file})" "$HOME/${filename}" || true
        fi
    done
    echo "dotfiles linked"

    echo "Creating dot files for local only configuration"
    for path in "${HOME}/.profile.local" "${HOME}/.bashrc.local" "${HOME}/.zshrc.local" "${HOME}/.rc_bash_zsh.local"; do
        if [ ! -f "${path}" ]; then
            echo " -> creating ${path}"
            echo "# This file is for your local configuration, and install scripts will add their modifications to this file" >>"${path}"
        fi
    done

    echo "Linking config dirs"
    mkdir -p "$HOME/.config"
    for d in $(find ${REPO_ROOT}/config -maxdepth 1 -mindepth 1 -type d); do
        local existing_path="${HOME}/.config/$(basename ${d})"
        local target_path="$(realpath ${d})"
        local backup_path="${CONFIG_BACKUP_DIR}/$(basename ${d})"
        if [ -d ${existing_path} ] && [ ! -L ${existing_path} ]; then
            echo "Backing up ${existing_path} to ${backup_path}"
            mv ${existing_path} ${backup_path}
        fi
        # FIXME: not working for some reason? Links even if the existing_path is a link
        if [ ! -L ${existing_path} ]; then
            echo "- ${existing_path} -> ${target_path}"
            ln -n -s ${target_path} ${existing_path}
        fi
    done
    echo "Done linking config dirs"


build_image:
    #!/bin/bash
    build_image() {
        local distro=$1
        docker build --build-arg UID=$(id -u) --build-arg USER=${USER} -f test_dockerfiles/Dockerfile.${distro} -t ${docker_prefix}${distro}:latest .
    }

    for value in "${distros[@]}"; do
        build_image ${value}
    done

