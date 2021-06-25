-- vim:fdm=marker
require 'settings'

require 'mappings'

require('pluginmanager').load('plugins')

-- color scheme
local base16 = require('base16')
base16(base16.themes['gruvbox-dark-hard'], true)
