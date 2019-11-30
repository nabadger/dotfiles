#
# ~/.profile
#
#

# Disable Ctrl-S (suspend) and Ctrl-Q (resume) in terminals
stty -ixon

# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# $PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Composer
# export PATH=$HOME/.config/composer/vendor/bin:./vendor/bin:$PATH

export DOTFILES=$HOME/dotfiles

# Reqired for git-signing
export GPG_TTY=$(tty)
