require'lualine'.setup{
    options = {
      theme = 'powerline_dark'
  },
    sections = {
      lualine_c = {'g:coc_status', 
                  'filename'}
  },
}
