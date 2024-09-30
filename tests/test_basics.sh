#!/bin/sh

. ${REPO_ROOT}/lib/sh/basic_utils_lib.sh
user_shell ${REPO_ROOT}/bootstrap.sh
root_shell ${REPO_ROOT}/scripts/basics.sh ${USER}
