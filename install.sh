#!/bin/sh

ln -s ./.vim ~/.vim
ln -s ./.vimrc ~/.vimrc

# install dein.vim
if [ ! -d "~/.cache/dein" ]; then
  mkdir -p ~/.cache/dein
  cd ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  sh ./installer.sh ~/.cache/dein
fi

ln -s ./.zshrc ~/.zshrc
ln -s ./.bashrc ~/.bashrc
source ~/.bashrc
source ~/.zshrc
