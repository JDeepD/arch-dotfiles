source $HOME/.config/nvim/plugged/plugins.vim


" Basic configs
set nu
set nocompatible
filetype plugin on
" turn hybrid line numbers on
set number relativenumber
set nu rnu
" maps the leader key to <Space>
let mapleader = " "

syntax on
imap jj <Esc>

"Gruvbox configs
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

"vim-smoothie keymaps
nmap <C-k> <C-u>k
nmap <C-j> <C-d>j

" Airline Theme
let g:airline_theme='deus'
