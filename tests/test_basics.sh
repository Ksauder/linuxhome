#!/bin/sh

. ${REPO_ROOT}/lib/sh/basic_utils_lib.sh
${REPO_ROOT}/homerepo bootstrap
sudo ${REPO_ROOT}/scripts/basics.sh ${1}
