#!/bin/bash

path=$(cd $(dirname $0); pwd)

if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.orig
fi
ln -s $path'/../.bashrc' ~/.bashrc

source ~/.bashrc
