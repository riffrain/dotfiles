#!/bin/sh

#----------
# vim
#----------
ln -s ./.vim ~/.vim
ln -s ./.vimrc ~/.vimrc

# install dein.vim
if [ ! -d "~/.cache/dein" ]; then
  mkdir -p ~/.cache/dein
  cd ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  sh ./installer.sh ~/.cache/dein
fi

#----------
# zsh
#----------
ln -s ./.zshrc ~/.zshrc
source ~/.zshrc

#----------
# bash
#----------
ln -s ./.bashrc ~/.bashrc
source ~/.bashrc

#----------
# fish
#----------
if [ ! -d "~/.config/fish" ]; then
  mkdir -p ~/.config/fish
  # install fish
fi

ln -s ./config.fish ~/.config/fish/config.fish
