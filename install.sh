#!/bin/sh

# this script won't be useful unless the repo is made public so unauthed requests can download it
git clone --recurse-submodules https://github.com/Ksauder/linuxhome ~/.homerepo
cd ~/.homerepo && ./bootstrap.sh

