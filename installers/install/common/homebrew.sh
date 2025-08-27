#!/bin/bash
set -e
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sudo apt-get update
sudo apt-get install build-essential gcc

echo >>/home/kyle/.zshrc.local
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/home/kyle/.zshrc.local
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
