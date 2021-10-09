source $HOME/.config/nvim/plugged/plugins.vim


" Basic configs
set nocompatible
filetype plugin on
" turn hybrid line numbers on
set number relativenumber
" maps the leader key to <Space>
let mapleader = " "

syntax on
imap jj <Esc>

"vim-smoothie keymaps
nmap <C-k> <C-u>k
nmap <C-j> <C-d>j

if exists('g:vscode')
	set nu! 
	set rnu!
	syntax off
	imap jj <Esc>
else
	"Gruvbox configs
	let g:gruvbox_contrast_dark = 'hard'
	colorscheme gruvbox
	" Airline Theme
	let g:airline_theme='deus'
endif
