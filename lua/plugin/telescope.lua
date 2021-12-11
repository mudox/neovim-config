---@diagnostic disable: lowercase-global
url = 'nvim-telescope/telescope.nvim'

requires = {
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
  {'fannheyward/telescope-coc.nvim'},
}

after = {'plenary.nvim', 'popup.nvim', 'telescope-fzf-native.nvim'}

event = 'VimEnter'
