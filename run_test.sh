#!/bin/sh

usage() {
    echo "$0: <test_filename> <testuser>"
}

if [ -z "${1}" ] || [ -z "${2}" ]; then
    usage
    exit 1
fi

export USER="${2}"
export REPO_ROOT="$(realpath $(dirname ${0}))"
TEST_DIR=${REPO_ROOT}/tests
TEST_FILE="${TEST_DIR}/${1}.sh"

if [ -f "${TEST_FILE}" ]; then
    ."${TEST_FILE}"
else
    usage
    echo "No file found for ${1}"
    exit 1
fi
