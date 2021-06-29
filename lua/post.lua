-- vim:fdm=marker

-- color scheme
local base16 = require('base16')
base16(base16.themes['gruvbox-dark-hard'], true)

vim.cmd [[
hi DiffAdd guibg=None
hi DiffDelete guibg=None
hi DiffChange guibg=None
]]

-- explicity load configs for lazy loading plugins
vim.cmd [[
  source ~/.config/nvim/lua/setup/airline.vim
]]

-- prevent built-in plugin loading
vim.g.loaded_netrwPlugin = true
