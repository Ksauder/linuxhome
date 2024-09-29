#!/bin/bash

# test ubuntus
TEST_CONT=debian12-test
# docker run --name $TEST_CONT -v $(pwd)/test_script.sh:/tmp/test_script.sh --entrypoint /tmp/test_script.sh --rm ubuntu:23.04 ubuntu
docker run --name $TEST_CONT -v $(pwd)/test_script.sh:/tmp/test_script.sh \
    -v ~/.homerepo:/home/ubuntu/.homerepo \
    --entrypoint /tmp/test_script.sh --rm debian:12 testuser

