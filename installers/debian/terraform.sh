#!/bin/bash

root_shell apt-get update
root_shell apt-get install -y gnupg software-properties-common curl

root_shell apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

curl -fsSL https://apt.releases.hashicorp.com/gpg | root_shell apt-key add -

root_shell apt-get update
root_shell apt-get install -y terraform
