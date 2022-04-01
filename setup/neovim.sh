#!/bin/bash

path=$(cd $(dirname $0); pwd)

if [ ! -d "~/.config" ]; then
  mkdir ~/.config
fi

if [ -d "~/.config/nvim" ]; then
  mv ~/.config/nvim ~/.config/nvim.original
fi
ln -s $path'/../vimfiles' ~/.config/nvim
