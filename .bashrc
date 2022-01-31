#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

fman() {
    man -k . | fzf -q \'"$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man | col -bx | bat -l man -p --color always' \
        | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}
# Get the colors in the opened man page itself
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"
