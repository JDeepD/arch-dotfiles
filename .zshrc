# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/antigen/antigen.zsh

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
alias rg="ranger"
alias fzfn='nvim $(fzf)' #Must use single quotes.
alias glog="git log --all --decorate --oneline --graph"
alias notes="nvim ~/notes/notes.md"
alias alacritty.yml="nvim ~/.config/alacritty/alacritty.yml"
alias btop="bpytop"
alias tmux.conf="nvim ~/.config/tmux/tmux.conf"
alias vifm="vifmrun"

# Antigen Plugins
antigen bundle zsh-users/zsh-syntax-highlighting >/dev/null
antigen bundle zsh-users/zsh-autosuggestions >/dev/null
antigen apply >/dev/null

# Environment variables
export STARSHIP_CONFIG=~/.config/starship/config.toml
export RANGER_LOAD_DEFAULT_RC=FALSE
export EDITOR=nvim
export FZF_DEFAULT_OPTS='--height 40% --border'
export GPG_TTY=$(tty)
export TERM=xterm-256color
# Export paths
pip_bin="/home/jdeep/.local/bin"
rofi_bin="/home/jdeep/.config/rofi/bin"
vifm_bin="/home/jdeep/.config/vifm/scripts"
export PATH="$PATH:${pip_bin}:${rofi_bin}:${vifm_bin}"


# Functions
function cheat {
  curl "https://cheat.sh/$1"
}

function vicd {
  local cwd="$(command vifm --choose-dir - "$@")" # cwd stores the current directory opened in vifm
  if [ -z "$cwd" ]; then
    echo 'Directory switching failed.'
    return 1
  fi
  
  cd "$cwd"
}


# eval "$(starship init zsh)"
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
