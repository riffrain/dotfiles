#!/bin/bash

path=$(cd $(dirname $0); pwd)

if [ ! -f ~/.gitconfig ]; then
  touch ~/.gitconfig
fi
echo "[include] path = "$path"/git/git-alias" >> ~/.gitconfig
if [ -f ~/.git-prompt.sh ]; then
  mv ~/.git-prompt.sh ~/.git-prompt.sh.orig
fi
ln -s $path'/../git/git-prompt.sh' ~/.git-prompt.sh
if [ -f ~/.git-completion.bash ]; then
  mv ~/.git-completion.bash ~/.git-completion.bash.orig
fi
ln -s $path'/../git/git-completion.bash' ~/.git-completion.bash
