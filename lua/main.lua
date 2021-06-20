-- vim:fdm=marker
require 'settings'

require 'mappings'

require('plug').load('plugins')

-- *
-- * Colorscheme
-- *

local base16 = require('base16')
base16(base16.themes['gruvbox-dark-hard'], true)

local theme_names = base16.theme_names()
local pos = 1
function cycle_theme()
  pos = (pos % #theme_names) + 1
  local name = theme_names[pos]
  print('base16: ' .. name)
  base16(base16.themes[name], true)
end
