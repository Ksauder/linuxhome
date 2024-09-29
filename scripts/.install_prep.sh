if [ -z "${_INSTALL_PREP}" ]; then
    _INSTALL_PREP=1
    REPO_SCRIPTS_DIR="$(realpath $(dirname $(realpath ${0}))/)"
    LIBDIR="$(realpath $(dirname $(realpath ${0}))/../lib)"
    . ${LIBDIR}/sh/basic_utils_lib.sh
    . ${LIBDIR}/sh/repo_tools_lib.sh

    THIS_LOGGER_FILE="/tmp/homerepo-install_$(date +%s).log"

    show_usage() {
        echo "Usage: $0 <username>"
        echo "This script performs an installation and needs to be run with root privileges."
    }

    if [ "$(id -u)" -ne 0 ]; then
        show_usage
        exit 1
    fi

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
    HOME=$(getent passwd "$USER" | cut -d: -f6)

    if [ ! -d "$HOME" ]; then
        echo "Home directory for user '$USER' does not exist" >&2
        exit 1
    fi
fi
