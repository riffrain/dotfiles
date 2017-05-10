#!/bin/bash

ln -s ./.vim ~/.vim
ln -s ./.vimrc ~/.vimrc
ln -s ./.zshrc ~/.zshrc


# install dein.vim
if [ ! -d "~/.cache/dein" ]; then
  mkdir -p ~/.cache/dein
  cd ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  sh ./installer.sh ~/.cache/dein
fi
