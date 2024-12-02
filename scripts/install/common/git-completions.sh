#!/bin/bash

git_version=$(git version | cut -d' ' -f 3)

bashrc=~/.bashrc
bashrcsnip="
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi
"

if [[ "${SHELL}" == "/bin/bash" ]]; then
    curl https://raw.githubusercontent.com/git/git/v${git_version}/contrib/completion/git-completion.bash -o ~/.git-completion.bash
    if ! grep -qF 'if [ -f ~/.git-completion.bash ]; then' ${bashrc} >/dev/null; then
        
        echo "${bashrcsnip}" > ${bashrc}
    fi
fi

