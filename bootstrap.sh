#!/bin/bash

chmod +x ./scripts/*

# init any submodules and run any machine setup scripts
scripts/install_omz.sh

# for file in repo, symlink to ~/
