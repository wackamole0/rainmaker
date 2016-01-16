#!/usr/bin/env bash

script_dir=$(dirname $0)
rainmaker_vagrant_box_name="rainmaker/rainmaker"

if [[ $(vagrant box list | fgrep $rainmaker_vagrant_box_name) != "" ]]; then
    echo 'The Rainmaker vagrant box is already installed.'
    exit 1
fi

command -v wget >/dev/null 2>&1 || { echo >&2 "wget is required to continue"; exit 1; }

# Download and install Rainmaker Vagrant box
cd $script_dir
wget -O rainmaker.box http://www.rainmaker-dev.com/boxes/rainmaker.box
vagrant box add rainmaker/rainmaker ./rainmaker.box

# Setup SSH Keys required to access Rainmaker
./configure-rainmaker-keys.php

# Configure resolver for rainmaker.localdev zone
echo 'nameserver 10.100.0.2' > /etc/resolver/localdev
