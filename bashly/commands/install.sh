#!/bin/bash
# TODO: make another script for bundlers?
# needed args: package

echo ${INSTALLERS_DIR}
echo ${REPO_ROOT}
echo ${args[@]}

# TODO: implement logging
# export INSTALLERS_LOGGER_FILE="/tmp/homerepo-install_$(date +%s).log"

. ${REPO_ROOT}/lib/sh/basic_utils_lib.sh

pre_flight() {
    if [[ $EUID == 0 ]]; then
        echo "Don't run this as root"
        exit 1
    fi
}

pre_flight
#exec_install_script
run_install_script "${args[package]}"
