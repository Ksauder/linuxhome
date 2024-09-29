#!/bin/sh

echo "Installing pyenv"
user_shell curl https://pyenv.run | bash
user_shell pyenv install 3.12
user_shell pyenv global 3.12
echo "Done installing pyenv"

user_shell python3 -m pip install --user pipx
user_shell python3 -m pipx ensurepath

