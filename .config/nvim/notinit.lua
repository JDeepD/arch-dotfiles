-- get vars
HOME = os.getenv("HOME")


-- macros
function map(mode, shortcut, command, is_noremap)
  if (is_noremap == 0) then 
    vim.nvim_set_keymap(mode, shortcut, command, {noremap = false, silent = true})
  else
    vim.nvim_set_keymap(mode, shortcut, command, {noremap = true,  silent = true})
  end
end

function imap(shortcut, command)
  vim.nvim_set_keymap("i", shortcut, command)
end

function nmap(shortcut, command)
  vim.nvim_set_keymap("n", shortcut, command)
end

function tnoremap(shortcut, command)
  vim.nvim_set_keymap("t", shortcut, command, {noremap = true})
end


-- Basic settings
vim.g.mapleader = " "
vim.o.encoding = "utf-8"
vim.o.tabstop = 4
vim.o.timeoutlen = 500
vim.o.cmdheight = 2
vim.o.updatetime = 300
vim.o.number = "relativenumber"
vim.o.hidden = true
vim.o.cursorline = true
vim.o.termguicolors = true

-- Keymappings
-- jj mapped to Esc
imap("jj", "Esc", 0)

nmap("<leader>w", "<C-w>", 1)
tnoremap("<leader>w", "<C-\><C-n><C-w>")

-- Space + i for autofixing code when possible
nmap("<leader>i", ":CocFix<CR>", 1)

-- Fast buffer switching using Ctrl + {h, l}
nmap("<C-h>", "<C-\><C-n>:bp<CR>")
nmap("<C-l>", "<C-\><C-n>:bn<CR>")



