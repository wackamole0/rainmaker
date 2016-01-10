#!/usr/bin/env bash

script_dir=$(dirname $0)
cd $script_dir

if [[ $(vagrant status | fgrep poweroff) == "" ]]; then
    echo 'Rainmaker is already running'
    exit 1
fi

vagrant up

./mount-nfs.sh
