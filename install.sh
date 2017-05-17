#!/bin/sh

# -------------------------------
# Editor

## vim
ln -s ./.vim ~/.vim
ln -s ./.vimrc ~/.vimrc

### install dein.vim
if [ ! -d "~/.cache/dein" ]; then
  mkdir -p ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.cache/dein/installer.sh
  sh ~/.cache/dein/installer.sh ~/.cache/dein
  ln -s dein.toml ~/.cache/dein/dein.toml
fi

# -------------------------------
# Shell

## zsh
ln -s ./.zshrc ~/.zshrc
source ~/.zshrc

## bash
ln -s ./.bashrc ~/.bashrc
source ~/.bashrc

## fish
if [ ! -d "~/.config/fish" ]; then
  mkdir -p ~/.config/fish

  echo 'please install `fish shell` and `fishserman`'
  echo 'install fisheman: curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher'

  ln -s ./config.fish ~/.config/fish/config.fish
fi

