source ~/.git-prompt.sh
source ~/.git-completion.bash

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=1000
shopt -s checkwinsize
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	    color_prompt=yes
    else
	    color_prompt=
    fi
fi
if [ "$color_prompt" = yes ]; then
  if [ -n "$VIMRUNTIME" ]; then
    PS1='\[\033[01;34m\][vim][\w\[\033[00m\]\[\033[01;32m\]$(__git_ps1 "(%s)")\[\033[00m\]\[\033[01;34m\]]\[\033[00m\] '
 else
    PS1='\[\033[01;34m\][\w\[\033[00m\]\[\033[01;32m\]$(__git_ps1 "(%s)")\[\033[00m\]\[\033[01;34m\]]\[\033[00m\] '
 fi
else
  if [ -n "$VIMRUNTIME" ]; then
    PS1='[vim][\w\$(__git_ps1 "(%s)")\] '
  else
    PS1='[\w\$(__git_ps1 "(%s)")\] '
  fi
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if command -v nvim &> /dev/null; then
  alias vi='nvim'
else
  alias vi='vim'
fi
alias ssh='ssh -A'
alias less='less -qR'

export EDITOR=vi
export GOROOT=$HOME/.go
export PATH=$HOME/.go/bin:$HOME/.local/bin:$HOME/.yarn/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=$HOME/.local/lib:$DYLD_LIBRARY_PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"
