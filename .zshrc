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

# Antigen Plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# Environment variables
export STARSHIP_CONFIG=~/.config/starship/config.toml
export RANGER_LOAD_DEFAULT_RC=FALSE
export EDITOR=nvim
export FZF_DEFAULT_OPTS='--height 40% --border'


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

eval "$(starship init zsh)"
