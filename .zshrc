export LANG=ja_JP.UTF-8

bindkey -v

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt interactive_comments
setopt ignore_eof
setopt no_flow_control
setopt no_beep
setopt print_eight_bit

autoload -Uz compinit && compinit
autoload -Uz colors && colors

if [ -f $HOME/.git-completion.zsh ]; then
  zstyle ':completion:*:*:git:*' script "$HOME/.git-completion.zsh"
fi
if [ -f $HOME/.git-prompt.sh ]; then
  source "$HOME/.git-prompt.sh"
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
setopt PROMPT_SUBST
PS1='%{$fg_bold[blue]%}%~%{$fg_bold[green]$(__git_ps1 "(%s)")%}'$'\n''$reset_color%# '

export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=$HOME/.local/lib:$DYLD_LIBRARY_PATH
export GOROOT=$HOME/.go
export PATH=$HOME/.go/bin:$HOME/.local/bin:$HOME/.yarn/bin:$PATH
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$HOME/.phpenv/bin:$PATH"

if command -v phpenv &> /dev/null; then
  eval "$(phpenv init -)"
fi

if command -v nvim &> /dev/null; then
  alias vi='nvim'
else
  alias vi='vim'
fi

if [ -f "$HOME/.zprofile" ]; then
  source "$HOME/.zprofile"
fi
