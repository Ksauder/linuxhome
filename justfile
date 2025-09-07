set tempdir := "/tmp"

DISTROS := "debian11 debian12 ubuntu20 ubuntu22 ubuntu24"
DOCKER_PREFIX := "homrepo_"
DRY_RUN := env("DRY_RUN", '0')
export REPO_ROOT := justfile_directory()
export INSTALLERS_DIR := justfile_directory() + "/installers"
export TEST_DIR := justfile_directory() + "/tests"
export PYTHONPATH := REPO_ROOT + "/lib/python"


build_image:
    #!/bin/bash
    build_image() {
        local distro=$1
        docker build --build-arg UID=$(id -u) --build-arg USER=${USER} -f test_dockerfiles/Dockerfile.${distro} -t ${docker_prefix}${distro}:latest .
    }

    for value in "${distros[@]}"; do
        build_image ${value}
    done

test:
    uv run pytest
