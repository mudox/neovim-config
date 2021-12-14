  local ncmd = require('keymap').ncmd
  ncmd([[\af]], 'Neoformat')

  vim.g.neoformat_enabled_python = {'black', 'docformatter'}
  vim.g.neoformat_enabled_lua = {'stylua'}
