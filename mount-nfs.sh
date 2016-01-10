#!/usr/bin/env bash

if [[ "$HOME" == "" ]]; then
    echo 'The environment $HOME is not defined.'
    exit 1
fi

mount_source="rainmaker.localdev:/export/rainmaker"
mount_target="$HOME/rainmaker"

if [[ $(df $mount_target | fgrep $mount_target) == "" ]]; then
    if [ ! -e $mount_target ]; then
        mkdir $mount_target
    fi

    mount -o rw -t nfs $mount_source $mount_target
else
    echo 'The Rainmaker NFS exports are already mounted.'
    exit 1
fi
