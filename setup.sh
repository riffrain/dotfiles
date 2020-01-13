#!/bin/sh

path=$(pwd)

# vim {{{
echo 'install editor'
ln -s $path'/.vim' ~/.vim
ln -s $path'/.vimrc' ~/.vimrc
# }}}

# neovim
if [ ! -d "~/.config/nvim" ]; then
  mkdir -p ~/.config/nvim
  ln -s $path'/.vimrc' ~/.config/nvim/init.vim
fi

# install dein.vim
if [ ! -d "~/.cache/dein" ]; then
  mkdir -p ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.cache/dein/installer.sh
  sh ~/.cache/dein/installer.sh ~/.cache/dein
  ln -s $path'/dein_config' ~/.cache/dein_config
fi

echo 'setup bash'
if [ -f ~/.bashrc ]; then
   unlink ~/.bashrc
fi
ln -s $path'/.bashrc' ~/.bashrc
#
echo 'setup inputrc'
if [ -f ~/.inputrc ]; then
  unlink ~/.inputrc
fi
ln -s $path'/.inputrc' ~/.inputrc

 echo 'add git tweaks'
 if [ -f ~/.gitconfig ]; then
   touch ~/.gitconfig
   echo "[include] path = "$path"/git/git-alias" >> ~/.gitconfig
 fi
 if [ -f ~/.git-prompt.sh ]; then
   unlink ~/.git-prompt.sh
 fi
 ln -s $path'/git/git-prompt.sh' ~/.git-prompt.sh

 if [ -f ~/.git-completion.bash ]; then
   unlink ~/.git-completion.bash
 fi
 ln -s $path'/git/git-completion.bash' ~/.git-completion.bash

 # apply
 source ~/.bashrc
