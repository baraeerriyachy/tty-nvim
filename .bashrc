#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

PS1='${arch_chroot:+($arch_chroot)}[\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]]\$ '

export EDITOR=nvim 
export OPENCV_LOG_LEVEL=ERROR
alias vim='nvim'
alias vi='nvim'
alias nano='nvim'

export PROMPT_COMMAND='printf "\033]7;file://%s%s\033\\" "$HOSTNAME" "$PWD"'
