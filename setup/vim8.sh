#!/bin/bash

path=$(cd $(dirname $0); pwd)

if [ -f ~/.vimrc ]; then
  echo 'move exists .vimrc (~/.vimrc -> ~/.vimrc.original)'
  mv ~/.vimrc ~/.vimrc.orig
fi
ln -s $path'/../.vimrc' ~/.vimrc
if [ -d "~/.vim" ]; then
  echo 'move exists .vim (~/.vim -> ~/.vim.original)'
  mv ~/.vim ~/.vim.original
fi
ln -s $path'/../vimfiles' ~/.vim
