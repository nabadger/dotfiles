#!/usr/bin/env zsh

ZSH=/usr/share/oh-my-zsh
export ZSH=/usr/share/oh-my-zsh

ZSH_THEME="afowler"
DISABLE_AUTO_UPDATE="true"

plugins=(
  git
  kube-ps1
  ssh-agent
)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/completion.zsh

KUBE_PS1_SYMBOL_ENABLE=false
PROMPT=$PROMPT'$(kube_ps1) '

export LANG=en_US.UTF-8
export EDITOR='vim'
export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export PATH="$HOME/go/bin:$HOME/.local/bin:$PATH:$HOME/.terraform.d/plugins"

alias tfswitch="${HOME}/bin/tfswitch -b ${HOME}/bin/terraform"
alias tgswitch="${HOME}/bin/tgswitch -b ${HOME}/bin/terragrunt"

eval $(thefuck --alias)
