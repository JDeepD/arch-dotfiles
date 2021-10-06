" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Gruvbox themes
Plug 'gruvbox-community/gruvbox'

" Better Syntax Support
Plug 'sheerun/vim-polyglot'

" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'

" Vim status bar
Plug 'itchyny/lightline.vim'

" Vim Smooth scrolling
Plug 'subnut/vim-smoothie'

"rainbow braces
Plug 'luochen1990/rainbow'

"Search for a character in the line with `f<char>` and move to that character
Plug 'unblevable/quick-scope'

call plug#end()

