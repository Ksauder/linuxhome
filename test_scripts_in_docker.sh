#!/bin/bash

REPO_ROOT=$(realpath $(dirname $0))
DOCKERFILES_DIR=${REPO_ROOT}/test_dockerfiles/
TESTUSER=testuser

test_debian12() {
    TEST_IMAGE=debian_12
    TEST_CONT=debian12-test
    docker remove -f ${TEST_CONT} 
    docker remove -f ${TEST_CONT}-done 
    
    docker build -f ${DOCKERFILES_DIR}/Dockerfile.${TEST_IMAGE} -t ${TEST_IMAGE}:latest --build-arg USER=${TESTUSER} ${REPO_ROOT}
    docker run --name ${TEST_CONT} \
        ${TEST_IMAGE} /home/${TESTUSER}/.homerepo/run_test.sh test_basics ${TESTUSER}
    
    docker commit ${TEST_CONT} ${TEST_CONT}-done
}

test_debian12
