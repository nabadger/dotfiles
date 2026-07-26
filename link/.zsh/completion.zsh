##############################################################################
# @file completion.zsh
# @date May, 2015
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2015, All Rights Reserved
# @license MIT
##############################################################################

if [ -d "$HOME/.ellipsis" ]; then
    fpath=($HOME/.ellipsis/comp $fpath)
fi

##############################################################################

autoload -U compinit colors zcalc
compinit -d
colors

##############################################################################
#

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if whence dircolors >/dev/null; then
    eval "$(dircolors -b)"
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
else
    export CLICOLOR=1
    zstyle ':completion:*:default' list-colors ''
fi
#zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*' rehash true                              # automatically find new executables in path 

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

##############################################################################

command -v gopass >/dev/null 2>&1
if [[ "$?" -eq 0 ]]; then
    source ~/.zsh/gopass-zsh.completion
fi

command -v pass >/dev/null 2>&1
if [[ "$?" -eq 0 ]]; then
    source ~/.zsh/gopass-zsh.completion
fi

command -v kubectl >/dev/null 2>&1
if [[ "$?" -eq 0 ]]; then
    source ~/.zsh/kubectl-zsh.completion
fi

command -v gcloud >/dev/null 2>&1
if [[ "$?" -eq 0 ]]; then
    source /opt/google-cloud-sdk/path.zsh.inc
    source /opt/google-cloud-sdk/completion.zsh.inc
fi
