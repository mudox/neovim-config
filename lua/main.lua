-- vim:fdm=marker
require 'settings'

require 'mappings'

require('pluginmanager').load('plugins')

-- color scheme
local base16 = require('base16')
base16(base16.themes['gruvbox-dark-hard'], true)

vim.cmd [[
hi DiffAdd guibg=None
hi DiffDelete guibg=None
hi DiffChange guibg=None
]]

-- prevent built-in plugin loading
vim.g.loaded_netrwPlugin = true
