#!/bin/sh

REPO_ROOT=$(dirname "$(realpath "$0")")
BACKUP_DIR="${HOME}/.dotfilebackups"

echo "Unlinking dotfiles"
for file in $(find ${REPO_ROOT}/dotfiles -maxdepth 1 -type f,l); do
    filename=$(basename "${file}")
    echo "- removing ${HOME}/${filename} -> ${file}"
    if [ -f "${HOME}/${filename}" ] && [ ! -L "${HOME}/${filename}" ]; then
        echo "- replacing ${filename} from ${BACKUP_DIR}"
        mv "${BACKUP_DIR}/${filename}.orig.bak" "$HOME/${filename}"
    else
        rm "${HOME}/${filename}"
    fi
done

# FIXME: should BACKUP_DIR hold all backups, including config dirs?
# check the backup dir for leftovers
if [ -d "${BACKUP_DIR}" ] && [ -z "$(ls -A "${BACKUP_DIR}")" ]; then
    rm -r "${BACKUP_DIR}"
else
    echo "Warning: '${BACKUP_DIR}' is not empty or does not exist."
    echo "Leftover backup files:"
    ls -l ${BACKUP_DIR}
fi

echo "Unlinking config dirs" # TODO: backup any conflicting dirs
for d in $(find ${REPO_ROOT}/config -maxdepth 1 -mindepth 1 -type d); do
    echo "- removing $HOME/.config/$(basename ${d}) -> $(realpath ${d})"
    rm "$HOME/.config/$(basename ${d})"
done
echo "Done unlinking config dirs"
