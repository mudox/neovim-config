---@diagnostic disable: lowercase-global

url = 'sbdchd/neoformat'

keys = {[[\af]]}

function config()
  local ncmd = require('keymap').ncmd

  ncmd([[\af]], 'Neoformat')

  -- vim.g.neoformat_enabled_python = {'isort', 'black', 'docformatter'}
  vim.g.neoformat_enabled_python = {'black', 'docformatter'}
end
