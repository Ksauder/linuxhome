#!/bin/bash

# required vars
# REPO_ROOT=$(dirname "$(realpath "$0")")
# BACKUP_DIR="${HOME}/.dotfilebackups"
# HOME

chmod +x ${REPO_ROOT}/scripts/*

# init any submodules and run any machine setup scripts

echo "Linking dotfiles"
mkdir -p ${BACKUP_DIR}
for file in $(find ${REPO_ROOT}/dotfiles -maxdepth 1 -type f,l); do
    filename=$(basename "${file}")
    echo "- ${HOME}/${filename} -> ${file}"
    if [ -f "${HOME}/${filename}" ] && [ ! -L "${HOME}/${filename}" ]; then
        # FIXME: what if the existing node isn't a file, but instead a symlink?
        mv "$HOME/${filename}" "${BACKUP_DIR}/${filename}.orig.bak"
    fi
    ln -s "$(realpath ${file})" "$HOME/${filename}"
done
echo "dotfiles linked"

echo "Linking config dirs" # TODO: backup any conflicting dirs
mkdir -p "$HOME/.config"
for d in $(find ${REPO_ROOT}/config -maxdepth 1 -mindepth 1 -type d); do
    echo "- $HOME/.config/$(basename ${d}) -> $(realpath ${d})"
    ln -s "$(realpath ${d})" "$HOME/.config/$(basename ${d})"
done
echo "Done linking config dirs"
