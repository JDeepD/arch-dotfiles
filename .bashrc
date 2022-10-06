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
export http_proxy="http://172.16.199.40:8080/"
export ftp_proxy="ftp://172.16.199.40:8080/"
export rsync_proxy="rsync://172.16.199.40:8080/"
export no_proxy="localhost,127.0.0.1,192.168.1.1,::1,*.local"
export HTTP_PROXY="http://172.16.199.40:8080/"
export FTP_PROXY="ftp://172.16.199.40:8080/"
export RSYNC_PROXY="rsync://172.16.199.40:8080/"
export NO_PROXY="localhost,127.0.0.1,192.168.1.1,::1,*.local"
export https_proxy="http://172.16.199.40:8080/"
export HTTPS_PROXY="http://172.16.199.40:8080/"
