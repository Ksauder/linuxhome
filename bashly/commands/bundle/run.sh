. ${REPO_ROOT}/lib/sh/basic_utils_lib.sh

if [[ $EUID == 0 ]]; then
    echo "Don't run this as root"
    exit 1
fi

run_bundle_script "${args[bundle_name]}"
