#!/bin/bash

path=$(cd $(dirname $0); pwd)

if [ -d "~/.vim" ]; then
  echo 'move exists .vim (~/.vim -> ~/.vim.original)'
  mv ~/.vim ~/.vim.original
fi
ln -s $path'/../vimfiles' ~/.vim
