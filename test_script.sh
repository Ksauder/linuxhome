#!/bin/sh

TESTUSER="$1"

apt update
apt install -y curl git
adduser --disabled-password -gecos "" $TESTUSER

echo "Testing"
#su -l $TESTUSER /bin/sh -c "curl https://raw.githubusercontent.com/ksauder/linuxhome/refs/heads/main/install.sh | sh"
/home/ubuntu/.homerepo/scripts/install/basics.sh $TESTUSER
