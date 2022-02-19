#!/bin/bash

path=$(cd $(dirname $0); pwd)

if [ -f ~/.zshrc ]; then
  mv ~/.zshrc ~/.zshrc.orig
fi
ln -s $path'/../.zshrc' ~/.zshrc
source ~/.zshrc
