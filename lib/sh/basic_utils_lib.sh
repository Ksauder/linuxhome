if [ -z "$_LIB_BASIC_UTILS" ]; then
    _LIB_BASIC_UTILS=1

    detect_os() {
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
        else
            echo "OS not detected using /etc/os-release."
            exit 1
        fi
    }

    source_rc() {
        if [ $SHELL = "/bin/zsh" ]; then
            . $HOME/.zshrc
        elif [ $SHELL = "/bin/bash" ]; then
            . $HOME/.bashrc
        else
            echo "Not using zsh or bash, cannot source a matching rc file"
        fi
    }

    root_shell() { # currently just bash
        sudo su root -c "/bin/bash -c '$*'"
    }

    run_install_script() {
        detect_os
        APP_NAME=${1}
        INSTALL_DIR="${REPO_ROOT}/installers/install/${OS}"

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
            echo "Apt updating"
            root_shell apt-get update 2>&1 >/dev/null
            if ! dpkg --get-selections | grep -w "apt-utils" >/dev/null; then
                echo -n "Installing apt-utils..."
                root_shell apt-get install apt-utils 2>&1 >/dev/null
                echo "  DONE"
            fi
            for PKG in "$@"; do
                echo -n "Installing ${PKG}..."
                DEBIAN_FRONTEND=noninteractive root_shell apt-get install -yq ${PKG} 2>&1 >/dev/null
                echo "  DONE"
            done
        fi
    }

    remove_packages() {
        detect_os
        if [ ${ID}="debian" ] || [ ${ID}="ubuntu" ]; then
            for PKG in "$@"; do
                echo -n "Removing ${PKG}..."
                root_shell DEBIAN_FRONTEND=noninteractive apt-get remove -yq ${PKG} 2>&1 >/dev/null || true
                echo "  DONE"
            done
        fi
    }
fi
