-- vim: fdm=marker fmr=〈,〉
local join = pl.path.join

-- Commonly used global paths
local _p = {}

-- Config directories 〈
-- in ~/.config/nvim
_p.root = vim.fn.stdpath('config')
_p.plugin = _p.root .. '/plugin'
_p.ftplugin = _p.root .. '/ftplugin'
_p.autoload = _p.root .. '/autoload'

_p.lua = _p.root .. '/lua'
_p.rock = _p.lua .. '/.rocks'
_p.lua_plugin = _p.lua .. '/plugin'
_p.lua_plugin_config = _p.lua_plugin .. '/config'
-- 〉

-- Data directories 〈
-- in ~/.local/share/nvim
_p.data = vim.fn.stdpath('data')
_p.site = join(_p.data, 'site')
-- 〉

-- Package directories 〈
-- stdpath('data')/site/mdx_nvim_mode/<g:mdx_nvim_mode>/pack/packer/{start,opt}

assert(vim.g.mdx_nvim_mode)

_p.mode = join(_p.site, 'mdx_nvim_mode', vim.g.mdx_nvim_mode)
vim.o.packpath = vim.o.packpath .. ',' .. _p.mode

_p.package_root = join(_p.mode, 'pack')

_p.packer_install = join(_p.package_root, 'packer/start/packer.nvim')
_p.packer_compiled = join(_p.site, 'packer_compiled',
                          vim.g.mdx_nvim_mode .. '.vim')
_p.packer_start = join(_p.package_root, 'pack/packer/start')
_p.packer_opt = join(_p.package_root, 'pack/packer/opt')
-- 〉

-- Resolve module path location to require 〈
--
-- module path = <cfg>/lua/mode/<mode_name>/<module_name>
--
-- fallback to lua root dir (shared) if given module file
-- is missing under specific mode directory
local function path(t, name)
  local prefix = ''
  local mode = vim.g.mdx_nvim_mode
  if mode ~= 'default' then
    prefix = ('mode/%s/'):format(mode)
  end

  local module_path = pl.path.join(stdpath.lua, prefix, name .. '.lua')
  if pl.path.isfile(module_path) then
    return prefix .. name
  else
    return name
  end
end
-- 〉

-- Module 〈
local M = setmetatable({}, {
  __call = path,
  __index = function(_, id)
    local r = _p[id]
    assert(r, ('acessing invalid path id `%s`'):format(id))
    return r
  end,
  -- prohibit adding new fields
  __newindex = function()
    error('`stdpath` is a constant variable')
  end,
})
-- 〉

-- Setup luarocks paths 〈

local path_dir = M.rock .. '/share/lua/5.1'
package.path = table.concat({
  ([[%s/?.lua]]):format(path_dir),
  ([[%s/?/init.lua]]):format(path_dir),
  package.path,
}, ';')

local cpath_dir = M.rock .. '/lib/lua/5.1'
package.cpath = table.concat({([[%s/?.so]]):format(cpath_dir), package.cpath},
                             ';')
-- 〉

return M
