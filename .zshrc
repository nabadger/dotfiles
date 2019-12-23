#!/usr/bin/env zsh

ZSH=/usr/share/oh-my-zsh
export ZSH=/usr/share/oh-my-zsh


# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="afowler"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


plugins=(
  git
  kubectl
  kube-ps1
  ssh-agent
)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

KUBE_PS1_SYMBOL_ENABLE=false
PROMPT=$PROMPT'$(kube_ps1) '

# User configuration

export LANG=en_US.UTF-8
export EDITOR='vim'
export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export PATH="$HOME/go/bin:$HOME/.local/bin:$PATH:$HOME/.terraform.d/plugins"
export BROWSER="firefox"

eval $(thefuck --alias)
