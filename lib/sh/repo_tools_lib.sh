
if [ -z "$_LIB_REPO_TOOLS" ]; then
    _LIB_REPO_TOOLS=1
    if [ -z "${REPO_SCRIPTS_DIR}" ]; then
        echo "Need to set REPO_SCRIPTS_DIR before using repo_tools_lib.sh"
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
        INSTALL_DIR="${REPO_SCRIPTS_DIR}/install/${OS}"
        echo ${INSTALL_DIR}

        if [ -d "${INSTALL_DIR}" ]; then
            if [ ! -z "${VERSION_ID}" ] && [ -d "${INSTALL_DIR}/${VERSION_ID}" ]; then
                INSTALL_DIR="${INSTALL_DIR}/${VERSION_ID}/"
            fi
            SCRIPT_PATH="${INSTALL_DIR}/${APP_NAME}.sh"
            echo ${SCRIPT_PATH}
            if [ -f "${SCRIPT_PATH}" ]; then
                echo "Running installation script for ${APP_NAME} on ${OS}"
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
            apt update >/dev/null
            for PKG in "$@"; do
                echo -n "Installing ${PKG}..."
                apt install -y ${PKG} >/dev/null
                echo "  DONE"
            done
        fi
    }       
fi
