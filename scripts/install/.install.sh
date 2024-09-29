#!/bin/sh

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
    app_name=$1
    install_path="/install/${OS}/"

    if [ -d "${install_path}" ]; then
        version_dir=$(find "${install_path}" -mindepth 1 -maxdepth 1 -type d | head -1)
        script_path="${version_dir}/${app_name}.sh"

        if [ -f "${script_path}" ]; then
            echo "Running installation script for ${app_name} on ${OS}"
            . "${script_path}"
        else
            echo "No installation script found for ${app_name} on ${OS} in ${script_path}"
            exit 1
        fi
    else
        echo "No install path for OS ${OS} at ${install_path}"
        exit 1
    fi
}

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <app_name>"
    exit 1
fi

detect_os
run_install_script $1

