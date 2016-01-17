#!/usr/bin/env bash

script_dir=$(dirname $0)
cd $script_dir

STATUS="$(vagrant status)"

if [[ $(echo "$STATUS" | fgrep poweroff) == "" ]]; then
    if [[ ! $(echo "$STATUS" | fgrep "The environment has not yet been created") ]]; then
        echo 'Rainmaker is already running'
        exit 1
    fi
fi

vagrant up

./mount-nfs.sh
