#!/bin/sh

path=$(pwd)

# -------------------------------
# Editor

## vim
echo 'install editor'
ln -s $path'/.vim' ~/.vim
ln -s $path'/.vimrc' ~/.vimrc

### install dein.vim
if [ ! -d "~/.cache/dein" ]; then
  mkdir -p ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.cache/dein/installer.sh
  sh ~/.cache/dein/installer.sh ~/.cache/dein
  ln -s $path'dein.toml' ~/.cache/dein/dein.toml
  ln -s $path'lazy.toml' ~/.cache/dein/lazy.toml
  ln -s $path'eovim.toml' ~/.cache/dein/neovim.toml
fi

# -------------------------------
# Shell

echo 'install shell'

## zsh
ln -s $path'/.zshrc' ~/.zshrc
source ~/.zshrc

## bash
ln -s $path'/.bashrc' ~/.bashrc
source ~/.bashrc

## fish
if [ ! -d "~/.config/fish" ]; then
  mkdir -p ~/.config/fish

  echo 'please install `fish shell` and `fishserman`'
  echo 'install fisheman: curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher'

  ln -s $path'/config.fish' ~/.config/fish/config.fish
fi

