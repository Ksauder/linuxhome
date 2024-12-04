#!/bin/sh

if ! command -v git 2>&1 >/dev/null; then
    echo "Git must be installed"
    exit 1;
fi

git clone --recurse-submodules https://github.com/Ksauder/linuxhome ~/.homerepo
cd ~/.homerepo && ./homerepo bootstrap

