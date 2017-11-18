#!/bin/sh

path=$(pwd)

## vim
echo 'install editor'
ln -s $path'/.vim' ~/.vim
ln -s $path'/.vimrc' ~/.vimrc

# neovim
if [ ! -d "~/.config/nvim" ]; then
  mkdir -p ~/.config/nvim
  ln -s $path'/.vim' ~/.config/nvim/init.vim
fi

### install dein.vim
if [ ! -d "~/.cache/dein" ]; then
  mkdir -p ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.cache/dein/installer.sh
  sh ~/.cache/dein/installer.sh ~/.cache/dein
  ln -s $path'/dein.toml' ~/.cache/dein/dein.toml
  ln -s $path'/lazy.toml' ~/.cache/dein/lazy.toml
  ln -s $path'/neovim.toml' ~/.cache/dein/neovim.toml
fi

