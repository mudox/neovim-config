-- vim: fdm=marker
--
-- Common paths
stdpath = require('path')

-- JavaScript
vim.g.node_host_prog = '/usr/local/bin/neovim-node-host'

-- python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

-- Local plugin
-- local function append_rtp(path)
-- local join = require('pl.path').join
-- local item = join(stdpath.root, path)
-- vim.o.runtimepath = vim.o.runtimepath .. ',' .. item
-- end

-- if vim.fn.has('vim_starting') then
-- append_rtp 'bundle/align'
-- end

-- convenient `dump` function
function dump(obj)
  print(require('inspect')(obj))
end

-- config
if vim.fn.exists('g:vscode') == 1 then
  require 'vscode.main'
else
  require 'main'
end
