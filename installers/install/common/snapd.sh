#!/bin/bash

root_shell apt-get install snapd
root_shell systemctl enable snapd
echo 'PATH=${PATH}:/snap/bin'
