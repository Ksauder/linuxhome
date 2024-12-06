#!/bin/bash

git_version=$(git version | cut -d' ' -f 3)

bashrc=~/.bashrc.local
# TODO: inserting stuff into *rc.local should be a function to handle the formatting and check if it exists
bashrcsnip="

# <${0} >
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi
# <${0} />

"

if [[ "${SHELL}" == "/bin/bash" ]]; then
    curl https://raw.githubusercontent.com/git/git/v${git_version}/contrib/completion/git-completion.bash -o ~/.git-completion.bash
    if ! grep -qF 'if [ -f ~/.git-completion.bash ]; then' ${bashrc} >/dev/null; then
        
        echo "${bashrcsnip}" > ${bashrc}
    fi
fi

