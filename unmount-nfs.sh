#!/usr/bin/env bash

if [[ "$HOME" == "" ]]; then
    echo 'The environment $HOME is not defined.'
    exit 1
fi

mount_source="rainmaker.localdev:/export/rainmaker"
mount_target="$HOME/rainmaker"

if [[ $(lsof $mount_target) == "" ]]; then
    if [[ $(df $mount_target | fgrep $mount_target) != "" ]]; then
        umount $mount_target
    fi
else
    echo 'Cannot unmount the Rainmaker NFS exports. Some files are still opening. See list below.'
    lsof $mount_target
    exit 1
fi
