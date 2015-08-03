# Check for an interactive session
[ -z "$PS1" ] && return

# Run ssh-agent and authorize my public key
. $HOME/.ssh/ssh-login

PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin:/usr/games/bin:$HOME/bin"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cal='cal -m'
alias df='df -h'
alias du='du -c -h'
alias ping='ping -c 5'

alias skype='LD_PRELOAD=/usr/lib64/libv4l/v4l1compat.so skype'
alias google-chrome-stable='LD_PRELOAD=/usr/lib64/libv4l/v4l1compat.so google-chrome-stable'

set -o vi

export PS1="\[\033[1;35m\][\u\[\033[0m\] \[\033[1;37m\]\w]\[\033[0m\]\[\033[1;31m\]$\[\033[0m\] "

export EDITOR="vim"

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk

test -r ~/sources/Java/algs4/bin/config.sh && source ~/sources/Java/algs4/bin/config.sh

export LESS="-R"
export LESS_TERMCAP_mb=$'\033[01;31m'
export LESS_TERMCAP_md=$'\033[01;38;5;74m'
export LESS_TERMCAP_me=$'\033[0m'
export LESS_TERMCAP_se=$'\033[0m'
export LESS_TERMCAP_so=$'\033[38;5;246m'
export LESS_TERMCAP_ue=$'\033[0m'
export LESS_TERMCAP_us=$'\033[04;38;5;146m'

complete -cf sudo
complete -cf man
complete -cf emerge
