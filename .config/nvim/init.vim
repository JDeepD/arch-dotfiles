source $HOME/.config/nvim/plugged/plugins.vim
source $HOME/.config/nvim/cp.vim
source $HOME/.config/nvim/cocconf.vim

" Basic configs
set encoding=utf-8

set hidden
set mouse+=a
set ts=4 sw=4
set cursorline
highlight Comment cterm=italic
set timeoutlen=500
set cmdheight=2
set updatetime=300
set shortmess+=c
set nocompatible
filetype plugin on
" turn hybrid line numbers on
set number relativenumber
" maps the leader key to <Space>
let mapleader = " "
syntax on
imap jj <Esc>
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

" Disable conceal level in json and md files set by Indent line plugin
let g:indentLine_fileTypeExclude = ['json', 'markdown']

" Disable python2 support
let g:loaded_python_provider = 0

"Useful for adding annoying `;` in C/Cpp files
" Just <Space>; in Normal mode to add `;` to end of line
nnoremap <leader>; mz$a;<Esc>`z

" Quick navs in Nvim terminal
nnoremap <leader>w <C-w>
tnoremap <leader>c <C-\><C-n>
tnoremap <leader>w <C-\><C-n><C-w>
tnoremap <C-h> <C-\><C-n>:bp<CR>
tnoremap <C-l> <C-\><C-n>:bn<CR>
nnoremap <leader>i :CocFix<CR>
nmap <leader>r :NERDTreeFocus<cr>R<c-w><c-p>


" Neovim fast buffer switching
nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>

" Hugo shortcode template
nnoremap <leader>t i{{< highlight lang >}}<Esc>mza{{< /highlight >}}<Esc>`za

" Nvim which key config
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"vim-smoothie keymaps
nmap <C-k> <C-u>k
nmap <C-j> <C-d>j

" Copying stuff from neovim clipboard to system clipboard
set clipboard+=unnamedplus
"Copy everything to system buffer
nnoremap YY gg"+yG

"Set colorscheme

if has("unix")
	nnoremap cpp :-1read ${HOME}/.config/nvim/templates/cptemplate.cpp<CR>
	nnoremap c1 :-1read ${HOME}/.config/nvim/templates/c1.c<CR>
	nnoremap c2 :-1read ${HOME}/.config/nvim/templates/c2.c<CR>
endif

" Coc.nvim config
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" NERDTree config 
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


" Telescope config
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Rainbow Parenthesis
let g:rainbow_active = 1

"Luaconfigs of plugins
lua <<EOF
-- Treesitter
require'nvim-treesitter.configs'.setup {
ensure_installed = {"python", "c", "cpp", "vim", "json", "yaml", "go", "html"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = { enable = true },
  },
}

-- Bufferline config
require("bufferline").setup{
  options = {
    separator_style = "thick"
  }
}

require('nvim-autopairs').setup{}
local npairs = require("nvim-autopairs")

npairs.setup({
	fast_wrap = {
	  map = '<M-e>',
	  map_cr=false,
	  chars = { '{', '[', '(', '"', "'" },
	  pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
	  offset = 0, -- Offset from pattern match
	  end_key = '$',
	  keys = 'qwertyuiopzxcvbnmasdfghjkl',
	  check_comma = true,
	  highlight = 'Search',
	  highlight_grey='Comment'
	},
})

local remap = vim.api.nvim_set_keymap

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    return vim.fn["coc#_select_confirm"]()
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})


EOF

" Lualine config
lua << END
  require'lualine'.setup{
    options = {
      theme = 'powerline_dark'
  },
    sections = {
      lualine_c = {'g:coc_status', 
                  'filename'}
  },
}
END

" Indentline config
let g:indentLine_setColors = 0

set termguicolors
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
colorscheme tokyonight
