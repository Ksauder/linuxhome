build_image() {
    local distro=$1
    docker build --build-arg UID=$(id -u) --build-arg USER=${USER} -f test_dockerfiles/Dockerfile.${distro} -t ${docker_prefix}${distro}:latest .
}

for value in "${distros[@]}"; do
    build_image ${value}
done


