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

zstyle ':completion:*:*:git:*' script "$HOME/.git-completion.zsh"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

source "$HOME/.git-prompt.sh"
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
setopt PROMPT_SUBST
if [ -n "$VIMRUNTIME" ]; then
  PS1='%{$fg_bold[blue]%}[vim]%~%{$fg_bold[green]$(__git_ps1 "(%s)")%}%{$fg_bold[blue]%}$reset_color %# '
else
  PS1='%{$fg_bold[blue]%}%~%{$fg_bold[green]$(__git_ps1 "(%s)")%}%{$fg_bold[blue]%}$reset_color %# '
fi
if [ -f "$HOME/.zprofile" ]; then
  source "$HOME/.zprofile"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob \"!.git/*\"'

export GOROOT=$HOME/.go
export PATH=$HOME/.go/bin:$HOME/.local/bin:$HOME/.yarn/bin:$PATH

if command -v nvim &> /dev/null; then
  alias vi='nvim'
else
  alias vi='vim'
fi
