
if [ -z "$_LIB_REPO_TOOLS" ]; then
    _LIB_REPO_TOOLS=1
    if [ -z "${REPO_ROOT}" ]; then
        echo "Need to set REPO_ROOT before using repo_tools_lib.sh"
        exit 1
    fi

    detect_os() {
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
        else
            echo "OS not detected using /etc/os-release."
            exit 1
        fi
    }

    run_install_script() {
        detect_os
        APP_NAME=${1}
        INSTALL_DIR="${REPO_ROOT}/scripts/install/${OS}"

        if [ -d "${INSTALL_DIR}" ]; then
            if [ ! -z "${VERSION_ID}" ] && [ -d "${INSTALL_DIR}/${VERSION_ID}" ]; then
                INSTALL_DIR="${INSTALL_DIR}/${VERSION_ID}/"
            fi
            SCRIPT_PATH="${INSTALL_DIR}/${APP_NAME}.sh"
            echo ${SCRIPT_PATH}
            if [ -f "${SCRIPT_PATH}" ]; then
                echo "Running installation script for ${APP_NAME} on ${OS}"
                # sourcing is probably the right call?
                . "${SCRIPT_PATH}"
            else
                echo "No installation script found for ${APP_NAME} on ${OS} in ${SCRIPT_PATH}"
                exit 1
            fi
        else
            echo "No install path for OS ${OS} at ${INSTALL_DIR}"
            exit 1
        fi
    }

    install_packages() {
        detect_os
        if [ ${ID}="debian" ] || [ ${ID}="ubuntu" ]; then
            echo "Apt updating" 
            apt-get update 2>&1 >/dev/null
            if ! dpkg --get-selections | grep -w "apt-utils" >/dev/null; then
                echo -n "Installing apt-utils..."
                apt-get install apt-utils 2>&1 >/dev/null
                echo "  DONE"
            fi
            for PKG in "$@"; do
                echo -n "Installing ${PKG}..."
                DEBIAN_FRONTEND=noninteractive apt-get install -yq ${PKG} 2>&1 >/dev/null
                echo "  DONE"
            done
        fi
    }

    remove_packages() {
        detect_os
        if [ ${ID}="debian" ] || [ ${ID}="ubuntu" ]; then
            for PKG in "$@"; do
                echo -n "Removing ${PKG}..."
                DEBIAN_FRONTEND=noninteractive apt-get remove -yq ${PKG} 2>&1 >/dev/null
                echo "  DONE"
            done
        fi
    }
fi
