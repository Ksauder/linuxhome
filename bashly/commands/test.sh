#!/bin/sh

# required vars
# REPO_ROOT=$(realpath $(dirname $0))
# TEST_DIR=${REPO_ROOT}/tests
# TEST_IMAGE=debian_12

#--user $(id -u):$(id -g) \
docker_test() {
    distro=${args[distro]}
    test=${args[test]}
    testfile="${TEST_DIR}/test_${test}.sh"
    
    echo "Testing ${test} on ${distro}"
    docker remove -f ${docker_prefix}${distro} || true
    
    docker run -t \
        -v ${REPO_ROOT}:${REPO_ROOT} \
        -e REPO_ROOT=${REPO_ROOT} \
        ${docker_prefix}${distro} bash -c "cd ${REPO_ROOT}; sudo -E ${testfile} ${USER}; id;"
    
    docker commit ${docker_prefix}${distro}
}

docker_test
