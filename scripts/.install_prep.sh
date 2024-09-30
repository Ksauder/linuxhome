if [ -z "${_INSTALL_PREP}" ]; then
    export _INSTALL_PREP=1
    export REPO_ROOT="$(realpath $(dirname $(realpath ${0}))/../)"
    export THIS_LOGGER_FILE="/tmp/homerepo-install_$(date +%s).log"
    . ${REPO_ROOT}/lib/sh/basic_utils_lib.sh
    . ${REPO_ROOT}/lib/sh/repo_tools_lib.sh

    show_usage() {
        echo "Usage: $0 <username>"
        echo "This script performs an installation and needs to be run with root privileges."
    }

    if [ "$(id -u)" -ne 0 ]; then
        show_usage
        exit 1
    fi
    echo "INSTALL PREP USER $1"
    USER="$1"

    if [ -z "$USER" ]; then
        show_usage
        exit 1
    fi

    if ! id "$USER" >/dev/null 2>&1; then
        show_usage
        echo "User '$USER' not found" >&2
        exit 1
    fi

    HOME=
    export HOME=$(getent passwd "$USER" | cut -d: -f6)

    if [ ! -d "$HOME" ]; then
        echo "Home directory for user '$USER' does not exist" >&2
        exit 1
    fi
fi
