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

    " Vim surround for doing alien shit
    Plug 'tpope/vim-surround'

    "Vim status bar
    "Plug 'vim-airline/vim-airline'
    "Plug 'vim-airline/vim-airline-themes'
    Plug 'nvim-lualine/lualine.nvim'

    "Theme
    Plug 'ayu-theme/ayu-vim'
    Plug 'gruvbox-community/gruvbox'

    "Smooth vertical scrolls
    Plug 'psliwka/vim-smoothie'

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

    " Vim-Bookmarks
    Plug 'MattesGroeger/vim-bookmarks'

    " Startify
    Plug 'mhinz/vim-startify'

    " Which key for cheat
    Plug 'liuchengxu/vim-which-key'

    " Buffer line for sexy buffers
    Plug 'kyazdani42/nvim-web-devicons' 
    Plug 'akinsho/bufferline.nvim'

    " An illegal plugin
    Plug 'tpope/vim-fugitive'

    " Indent lines
    Plug 'Yggdroot/indentLine'

    " Toggle term
    Plug 'akinsho/toggleterm.nvim'

    " Markdown preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    "Graphical debugger
    Plug 'puremourning/vimspector'


call plug#end()
