" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'

    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    "Vim status bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    "Gruvbox Theme
    Plug 'gruvbox-community/gruvbox'

    "Smooth vertical scrolls
    Plug 'psliwka/vim-smoothie'
    Plug 'karb94/neoscroll.nvim'

    "rainbow braces
    Plug 'luochen1990/rainbow'

    "Search for a character in the line with `f<char>` and move to that
    "character
    Plug 'unblevable/quick-scope'

    "Comment out lines in any script using `gcc`
    Plug 'tpope/vim-commentary'

    "devicons for vifm
    Plug 'ryanoasis/vim-devicons'

    "Autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    "File-Explorer in neovim
    Plug 'preservim/nerdtree'

    " Neovim Telescope & lua func & treesitter for highlighting
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'nvim-treesitter/nvim-treesitter-refactor'

    " Startup time
    Plug 'dstein64/vim-startuptime'




    call plug#end()
