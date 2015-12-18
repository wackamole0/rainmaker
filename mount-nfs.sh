#!/bin/bash

if [ ! -e ~/rainmaker ];
then
  mkdir ~/rainmaker
fi

mount -o rw -t nfs rainmaker.localdev:/export/rainmaker ~/rainmaker

