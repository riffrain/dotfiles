#!/bin/sh

#----------
# vim
#----------
ln -s ./.vim ~/.vim
ln -s ./.vimrc ~/.vimrc

# install dein.vim
if [ ! -d "~/.cache/dein" ]; then
  mkdir -p ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.cache/dein/installer.sh
  sh ~/.cache/dein/installer.sh ~/.cache/dein
  ln -s dein.toml ~/.cache/dein/dein.toml
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
