#!/usr/bin/env bash

script_dir=$(dirname $0)
cd $script_dir

STATUS="$(vagrant status)"

POWEROFF=false
if [[ $(echo "$STATUS" | fgrep poweroff) == "" ]]; then
  POWEROFF=true
fi

NEWENV=false
if [[ $(echo "$STATUS" | fgrep "The environment has not yet been created") ]]; then
  NEWENV=true
fi

ABORTED=true
if [[ $(echo "$STATUS" | fgrep "The VM is in an aborted state") ]]; then
  ABORTED=true
fi

if [[ "$NEWENV" == false && "$ABORTED" == false && "$POWEROFF" == true ]]; then
  echo 'Rainmaker is already running'
  exit 1
fi

vagrant up

./mount-nfs.sh

echo "Rainmaker was started successfully"
