# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.cargo/env
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/zsh-cache/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jdeep/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey -v
export KEYTIMEOUT=20 #It makes sure that mapping jj to Esc is possible and there is enough time for zsh to recoginise double `jj`


# vim keybindings for zsh. Allows to use vim keys in autocomplete suggestions tab
zmodload -i zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -M viins 'jj' vi-cmd-mode #Maps the jj key to Escape 


# Change cursor shape for different vi modes. Use `|` for insert and █ for normal mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Aliases
alias .zshrc="nvim ~/.zshrc"
alias starship.config="nvim ~/.config/starship/config.toml"
alias init.vim="nvim ~/.config/nvim/init.vim"
alias plugins.vim="nvim ~/.config/nvim/plugged/plugins.vim"
alias szshrc="source ~/.zshrc"
alias c="clear"
alias fzfn='nvim $(fzf)' #Must use single quotes.
alias glog="git log --all --decorate --oneline --graph"
alias notes="nvim ~/notes/notes.md"
alias alacritty.yml="nvim ~/.config/alacritty/alacritty.yml"
alias btop="bpytop"
alias tmux.conf="nvim ~/.config/tmux/tmux.conf"
alias ls="ls --color=auto"
alias ip="ip -c" # -c -> --color
alias la="(exa -ahl --color=always --group-directories-first ) | bat --paging never --style=numbers"
alias tree="exa -T"
alias matlab="matlab -desktop -nosoftwareopengl &> /dev/null"

function uns() {
	proxyman unset
	unset {http,https,ftp,rsync,no}_proxy
	unset {HTTP,HTTPS,FTP,RSYNC,NO}_PROXY
}

# Environment variables
export STARSHIP_CONFIG=~/.config/starship/config.toml
export RANGER_LOAD_DEFAULT_RC=FALSE
export EDITOR=nvim
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden -E .git -E node_modules -E .npm"
export FZF_DEFAULT_OPTS='--prompt=" " --height 40%'
export GPG_TTY=$(tty)
export TERM=xterm-256color
# Export paths
pip_bin="/home/jdeep/.local/bin"
rofi_bin="/home/jdeep/.config/rofi/bin"
export PATH="$PATH:${pip_bin}:${rofi_bin}"


function post-web {
  local commit="$1"
  local website="/home/jdeep/Desktop/website/"
  local public="/home/jdeep/Desktop/website/public/"
  echo "cd $website"
  cd $website || return 1 
  echo "Building site..."
  if hugo --ignoreCache --cleanDestinationDir; then
    echo "Commiting and Pushing changes to website..."
    echo
    git add -A &> /dev/null
    git commit -m "New post" &> /dev/null
    git push origin main &> /dev/null

    echo "cd $public"
    cd $public || return 1
	echo jdeep.me > CNAME
    git add -A &> /dev/null
    git commit -m "New post" &> /dev/null
    git push -f origin main &> /dev/null
    echo "Done..."

    echo "cd $website" || return 1
    cd $website || return 1
    return 0
  else
    return 1
  fi
}

# Functions
function cheat {
  curl "https://cht.sh/$1"
}

fman() {
    	man -k . |
		fzf --exact -q "$1" --prompt='man> '  --preview $'echo {} |
		tr -d \'()\' |
		awk \'{printf "%s ", $2} {print $1}\' |
		xargs -r man |
		col -bx |
		bat -l man -p --color always'|
		tr -d '()' | awk '{printf "%s ", $2} {print $1}' |
		xargs -r man
}
# Get the colors in the opened man page itself
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"


yi() {
  SELECTED_PKGS="$(yay -Slq | fzf --header='Install packages' -m --height 100% --preview 'yay -Si {1}')"
  if [ -n "$SELECTED_PKGS" ]; then
    yay -S $(echo $SELECTED_PKGS)
  fi
}

yr() {
  SELECTED_PKGS="$(yay -Qsq | fzf --exact --header='Remove packages' -m --height 100% --preview 'yay -Si {1}')"
  if [ -n "$SELECTED_PKGS" ]; then
    yay -Rns $(echo $SELECTED_PKGS)
  fi
}

fcd() {
	local dir
	dir="$(fd --type d --no-ignore --no-hidden |
		fzf --exact --preview="exa --tree {}" --prompt="cd > " --bind tab:preview-page-up,btab:preview-page-down -0)" && 
		cd "${dir}" || return 1
}


fvim(){
	local fil
	fil="$(fd --type f |
		fzf --exact --preview="bat --color=always {}" --prompt="${EDITOR}> " --bind tab:preview-page-up,btab:preview-page-down -0)" && 
		${EDITOR} "${fil}" || return 1
}

fif (){
	fil="$(rg . | fzf --exact )"
}

fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) |
	  fzf +s --tac |
	  sed -E 's/ *[0-9]*\*? *//' |
	  sed -E 's/\\/\\\\/g')
}



eval "$(zoxide init zsh)" # Enable zoxide
# eval "$(starship init zsh)"
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/jdeep/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/jdeep/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/jdeep/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/jdeep/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

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
