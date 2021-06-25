-- Commonly used global paths
local _p = {}

-- config dir
-- ~/.config/nvim
_p.root = vim.fn.stdpath('config')
_p.plugin = _p.root .. '/plugin'
_p.ftplugin = _p.root .. '/ftplugin'
_p.autoload = _p.root .. '/autoload'

_p.lua = _p.root .. '/lua'
_p.rock = _p.lua .. '/.rocks'
_p.pack = _p.lua .. '/pack'
_p.luaplugin = _p.lua .. '/plugin'

-- data dir
-- ~/.local/share/nvim
_p.data = vim.fn.stdpath('data')
_p.site = _p.data .. '/site'
_p.pack = _p.site .. '/pack'

local M = {}

setmetatable(M, {
  __index = function(_, id)
    local r = _p[id]
    assert(r, ('acessing invalid path id `%s`'):format(id))
    return r
  end,
  __newindex = function()
    error('`M` is a constant variable')
  end,
})

-- Setup package paths

local path_dir = M.rock .. '/share/lua/5.1'
package.path = table.concat({
  ([[%s/?.lua]]):format(path_dir),
  ([[%s/?/init.lua]]):format(path_dir),
  package.path,
}, ';')

-- LuaFormatter off
local cpath_dir = M.rock .. '/lib/lua/5.1'
package.cpath = table.concat({
  ([[%s/?.so]]):format(cpath_dir),
  package.cpath
}, ';')
-- LuaFormatter on

return M
