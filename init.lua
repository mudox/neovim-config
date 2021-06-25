-- vim: fdm=marker
--
-- Penlight
pl = require('pl.import_into')()

-- Commonew paths
stdpath = require('path')

-- JavaScript
vim.g.node_host_prog = '/usr/local/bin/neovim-node-host'

-- python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

-- config
if vim.fn.exists('g:vscode') == 1 then
  require 'vscode.main'
else
  require 'main'
end
