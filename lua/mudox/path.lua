-- vim: fdm=marker fmr=\ 〈,\ 〉
local join = pl.path.join

-- Commonly used global paths
local _p = {}

-- Config directories 〈
-- in ~/.config/nvim
_p.config = vim.fn.stdpath("config")
_p.plugin = join(_p.config, "plugin")
_p.ftplugin = join(_p.config, "ftplugin")
_p.autoload = join(_p.config, "autoload")

_p.lua = join(_p.config, "lua")
_p.mudox = join(_p.lua, "mudox")
_p.lua_plugin = join(_p.mudox, "plugin")
_p.lua_plugin_config = join(_p.lua_plugin, "config")
_p.lua_plugin_setup = join(_p.lua_plugin, "setup")
-- 〉

-- Data directories 〈
-- in ~/.local/share/nvim
_p.data = vim.fn.stdpath("data")
_p.site = join(_p.data, "site")
-- 〉

-- Package directories 〈
-- stdpath('data')/site/mdx_nvim_mode/<g:mdx_nvim_mode>/pack/packer/{start,opt}

_p.my_pack = join(_p.site, "pack/mudox")
_p.my_snippets = join(_p.my_pack, "start/vim-mysnippets")

assert(vim.g.mdx_nvim_mode)

_p.mode = join(_p.site, "mdx_nvim_mode", vim.g.mdx_nvim_mode)
vim.opt.packpath:append(_p.mode)

_p.pack = join(_p.mode, "pack") -- `package_root` of packer.nvim
_p.packer = join(_p.pack, "packer")

_p.packer_install = join(_p.packer, "start/packer.nvim")
_p.packer_compiled = join(_p.lua, "packer_compiled", vim.g.mdx_nvim_mode .. ".lua")
_p.packer_start = join(_p.packer, "start")
_p.packer_opt = join(_p.packer, "opt")
-- 〉

-- Resolve module path location to require 〈
--
-- module path = <cfg>/lua/mode/<mode_name>/<module_name>
--
-- fallback to lua root dir (shared) if given module file
-- is missing under specific mode directory
local function path(_, name)
  local prefix = ("mudox/mode/%s/"):format(vim.g.mdx_nvim_mode)

  local module_path = join(stdpath.lua, prefix, name .. ".lua")
  if pl.path.isfile(module_path) then
    return prefix .. name
  else
    -- fallback to `default` files
    return "mudox/mode/" .. name
  end
end
-- 〉

-- Module 〈

local M = setmetatable({}, {
  __call = path,
  __index = function(_, id)
    local r = _p[id]
    assert(r, ("acessing invalid path id `%s`"):format(id))
    return r
  end,
  -- prohibit adding new fields
  __newindex = function()
    error("`stdpath` is a constant variable")
  end,
})

-- 〉

return M
