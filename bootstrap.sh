#!/bin/bash

chmod +x ./scripts/*

# init any submodules and run any machine setup scripts
scripts/install_from_submodules.sh

# for file in repo, symlink to ~/
echo "Linking dotfiles"
for file in $(find . -maxdepth 1 -type f); do
    filename=$(basename "$file")
    if [ "${filename:0:1}" = "." ] && [ "${filename}" != ".gitmodules" ]; then
        echo "- $HOME/$filename -> ${filename}"
        ln -s "$(realpath $file)" "$HOME/$filename"
    fi
done
echo "dotfiles linked"

echo "Linking config dirs"
mkdir -p "$HOME/.config"
for d in $(find ./config -maxdepth 1 -mindepth 1 -type d); do
    echo "- $HOME/.config/$(basename $d) -> $(realpath $d)"
    ln -s "$(realpath $d)" "$HOME/.config/$(basename $d)"
done
echo "Done linking config dirs"