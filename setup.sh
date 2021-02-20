#!/bin/sh

path=$(pwd)

# agignore {{{
if [ -f ~/.agignore ]; then
  mv ~/.agignore ~/.agignore.orig
fi
ln -s $path'/.agignore' ~/.agignore
# }}}

# vim {{{
ln -s $path'/.vim' ~/.vim
ln -s $path'/.vimrc' ~/.vimrc
if [ ! -d "~/.cache/dein" ]; then
  mkdir -p ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.cache/dein/installer.sh
  sh ~/.cache/dein/installer.sh ~/.cache/dein
  ln -s $path'/dein_config' ~/.cache/dein_config
fi
# }}}

# bash {{{
if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.orig
fi
ln -s $path'/.bashrc' ~/.bashrc
# }}}

# inputrc {{{
if [ -f ~/.inputrc ]; then
  mv ~/.inputrc ~/.inputrc.orig
fi
ln -s $path'/.inputrc' ~/.inputrc
# }}}

# zsh {{{
if [ -f ~/.zshrc ]; then
  mv ~/.zshrc ~/.zshrc.orig
fi
ln -s $path'/.zshrc' ~/.zshrc
# }}}

# git {{{
if [ ! -f ~/.gitconfig ]; then
  touch ~/.gitconfig
fi
echo "[include] path = "$path"/git/git-alias" >> ~/.gitconfig

if [ -f ~/.git-prompt.sh ]; then
  mv ~/.git-prompt.sh ~/.git-prompt.sh.orig
fi
ln -s $path'/git/git-prompt.sh' ~/.git-prompt.sh

if [ -f ~/.git-completion.bash ]; then
  mv ~/.git-completion.bash ~/.git-completion.bash.orig
fi
ln -s $path'/git/git-completion.bash' ~/.git-completion.bash
# }}}

# Apply
if [ -n "$ZSH_VERSION" ]; then
  source ~/.zshrc
elif [ -n "$BASH_VERSION" ]; then
  source ~/.bashrc
fi
