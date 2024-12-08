#!/bin/bash
# TODO: make another script for bundlers?
# needed args: package

echo ${INSTALLERS_DIR}
echo ${REPO_ROOT}
echo ${args[@]}
export INSTALLERS_LOGGER_FILE="/tmp/homerepo-install_$(date +%s).log"

. ${REPO_ROOT}/lib/sh/basic_utils_lib.sh
. ${REPO_ROOT}/lib/sh/repo_tools_lib.sh

show_usage() {
    echo "Usage: $0 [HOMEREPO_USER]"
}

pre_flight() {
    # TODO: validate the id command and user properly
    HOMEREPO_USER=${1:-$(id -un)}
    if [ -z "$HOMEREPO_USER" ]; then
        echo "HOMEREPO_USER needs to be set accurately"
        show_usage
        exit 1
    else
        echo "install for user ${HOMEREPO_USER}"
    fi

    if ! id "$HOMEREPO_USER" >/dev/null 2>&1; then
        show_usage
        echo "User '$HOMEREPO_USER' not found" >&2
        exit 1
    fi

    # TODO: validate the home dir, might not have to use getent, but maybe validate HOME vs getent passwd?
    HOME=
    export HOME=$(getent passwd "$HOMEREPO_USER" | cut -d: -f6)
    if [ ! -d "$HOME" ]; then
        echo "Home directory for user '$HOMEREPO_USER' does not exist" >&2
        exit 1
    fi

    if [[ $EUID -e 0 ]]; then
        echo "Don't run this as root"
        exit 1
    fi
}

exec_install_script() {
    # TODO: get distro information
    # TODO: create util to match a passed package name with the proper distro script
    # TODO: exec the script as root and pass all needed args and env vars
    exec sudo "${REPO_ROOT}/testinstall.sh" "${args[@]}"
}

pre_flight
