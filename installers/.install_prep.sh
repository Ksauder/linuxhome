if [ -z "${_INSTALL_PREP}" ]; then
    export _INSTALL_PREP=1
    export REPO_ROOT="$(realpath $(dirname $(realpath ${0}))/../)"
    export THIS_LOGGER_FILE="/tmp/homerepo-install_$(date +%s).log"
    . ${REPO_ROOT}/lib/sh/basic_utils_lib.sh
    . ${REPO_ROOT}/lib/sh/repo_tools_lib.sh

    show_usage() {
        echo "Usage: $0 HOMEREPO_USER"
        echo "This script performs an installation and needs to be run with root privileges."
    }

    if [ "$(id -u)" -ne 0 ]; then
        show_usage
        exit 1
    fi

    HOMEREPO_USER=${1}

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
    
    HOME=
    export HOME=$(getent passwd "$HOMEREPO_USER" | cut -d: -f6)

    if [ ! -d "$HOME" ]; then
        echo "Home directory for user '$HOMEREPO_USER' does not exist" >&2
        exit 1
    fi
fi
