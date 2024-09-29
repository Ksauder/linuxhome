# lib/mylibrary.sh
if [ -z "$_LIB_BASIC_UTILS" ]; then
    _LIB_BASIC_UTILS=1
    source_rc () {
        if [ $SHELL = "/bin/zsh" ]; then
            . $HOME/.zshrc
        elif [ $SHELL = "/bin/bash" ]; then
            . $HOME/.bashrc
        else
            echo "Not using zsh or bash, cannot source a matching rc file"
        fi
    }

    shell () {
        LOCUSER=${1}
        shift
        if command -v bash 2>%1 >/dev/null; then
            su -l $LOCUSER bash -c "$*"
        elif command -v zsh 2>%1 >/dev/null; then
            su -l $LOCUSER zsh -c "$*"
        else
            echo "Neither bash nor zsh has been found, cannot execute command"
            exit 1
        fi
    }

    user_shell () {
        shell $USER "$@"
    }

    root_shell () {
        shell root "$@"
    }
fi
