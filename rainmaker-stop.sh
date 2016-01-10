#!/usr/bin/env bash

script_dir=$(dirname $0)
cd $script_dir

if [[ $(vagrant status | fgrep running) == "" ]]; then
    echo 'Rainmaker is not running'
    exit 1
fi

./unmount-nfs.sh

if [[ $? -ne 0 ]]; then
    exit 1
fi

vagrant halt

