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

-- Load Config

--- Load module according to `mode`
-- if mode is not `default`, then try require `name` from 'mode.<mode_name>'
-- otherwise require `name` from root directory
local mode
if vim.fn.exists('g:vscode') == 1 then
  mode = 'vscode'
else
  mode = os.getenv('MDX_NVIM_MODE') or 'default'
end

local prefix = ''
if mode ~= 'default' then
  prefix = ('mode/%s/'):format(mode)
end

local function findPath(name)
  local modulePath = pl.path.join(stdpath.lua, prefix, name, '.lua')
  if pl.path.isfile(modulePath) then
    return prefix .. name
  else
    return name
  end
end

require(findPath('settings'))
require(findPath('mappings'))

require('pluginmanager').load(findPath('plugins'))

require(findPath('post'))
