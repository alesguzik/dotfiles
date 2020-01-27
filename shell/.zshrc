HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=10000000
setopt appendhistory autocd nobeep extendedglob no_bad_pattern no_nomatch notify #print_exit_value

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
autoload -Uz vcs_info
autoload -U select-word-style && select-word-style bash
autoload -U promptinit && promptinit
autoload -U colors && colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{yellow}%d%f%u'
zstyle ':vcs_info:*' enable git

bindkey -e
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)"
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey '^i' expand-or-complete-prefix

#unsetopt share_history

function source-if-exist { [ -e "$1" ] && source "$1" }
function which-s { realpath "$(which "$@")" } 

setopt PROMPT_SUBST
function precmd { }
export PS1="\$(/home/ales/p/prompt/ps1)"
export RPS1="\$(/home/ales/p/prompt/rps1)"

#tabs -4
TERM=linux setterm -regtabs 4

### ENVIRONMENT AND STARTUP ###
# .zprofile -> at login
###############################

source "$HOME/.env-reloadable"
source "$HOME/.aliases"

function L { eval "${history[$(expr "$HISTCMD" - 1)]}| $PAGER" }
function F { eval "${history[$(expr "$HISTCMD" - 1)]}| fzf --reverse" }
#eval "$(rbenv init -)"
#eval "$(pyenv init -)"
#eval "$($HOME/.rakudobrew/bin/rakudobrew init -)"
[ -z "$DISABLE_DIRENV" ] && eval "$(direnv hook zsh)"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source-if-exist "$HOME/p/fork/z/z.sh"
# eval "$("$HOME/p/work/synchrony/run" compinstall)"
