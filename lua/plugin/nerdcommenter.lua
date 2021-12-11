---@diagnostic disable: lowercase-global

url = 'scrooloose/nerdcommenter'

event = 'VimEnter'

function config()
  local g = vim.g
  local nplug = require('keymap').nplug

  g.NERDBlockComIgnoreEmpty = 1
  g.NERDSpaceDelims = 1
  g.NERDDefaultNesting = 0

  nplug('', 'NERDCommenterToggle')
end
