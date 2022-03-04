-- vim: fdm=marker fmr=〈,〉
local p = pl.path

-- Bootstrap 〈

-- impatient.nvim 〈
-- TODO: remove when `impatient.nvim` is merged into Neovim
local impatient_install = p.join(stdpath.packer, "start/impatient.nvim")
if not p.exists(impatient_install) then
  print "Installing `impatient.nvim` ..."
  vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/lewis6991/impatient.nvim",
    impatient_install,
  }
end

vim.opt.runtimepath:append(impatient_install)
require "impatient"
-- 〉

-- packer.nvim 〈
local is_bootstrap = false
if not p.exists(stdpath.packer_install) then
  print "Installing packer.nvim ..."
  is_bootstrap = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    stdpath.packer_install,
  }
end

vim.opt.runtimepath:append(stdpath.packer_install)
-- 〉

-- 〉

-- Plugin config file smart discovery 〈

-- if `config` is missing in plugin spec file and there is a <name>.{lua,vim} file under
-- lua/plugin/config folder, construct a `config` function to `require/source` this file
local function fallback_config(path)
  local name = p.basename(p.splitext(path))

  local luaFile = ("%s/%s.lua"):format(stdpath.lua_plugin_config, name)
  if p.isfile(luaFile) then
    local code = ([[
      require 'mudox.plugin.config.%s'
    ]]):format(name)

    return load(code)
  end

  local vimFile = ("%s/%s.vim"):format(stdpath.lua_plugin_config, name)
  if p.isfile(vimFile) then
    local code = ([[
      vim.cmd('source %s')
    ]]):format(vimFile)

    return load(code)
  end
end

-- 〉

-- Plugin spec DSL 〈

--- parses plugin spec DSL files
local function parse_spec(pattern)
  local pat = p.join(stdpath.lua_plugin, pattern .. ".lua")
  local paths = vim.fn.glob(pat, false, true)
  assert(#paths > 0, "failed to glob plugin spec pattern: " .. pat)

  local envs = {}
  for _, path in ipairs(paths) do
    local chunk = loadfile(path)
    assert(chunk, "invalid spec path: " .. path)

    local env = {
      stdpath = stdpath,
      pl = pl,
    }
    ---@diagnostic disable-next-line: deprecated
    setfenv(chunk, env)()

    -- url
    assert(type(env.url) == "string", ("invalid `url` field in %s"):format(path))
    env[1] = env.url
    env.url = nil

    -- config
    env.config = env.config or fallback_config(path)

    table.insert(envs, env)
  end

  return envs
end

-- 〉

-- Config packer 〈

local packer_opts = {
  -- mode separation
  package_root = stdpath.pack,
  compile_path = stdpath.packer_compiled,
  -- appearence
  display = {
    open_fn = function()
      return require("packer.util").float { border = "solid" }
    end,
  },
}

-- 〉

-- Init packer.nvim 〈

--- @example: require('pluginmanager').load(stdpath('plugins'))
local function load(path)
  require("packer").startup {
    function(use)
      for _, pat in ipairs(require(path)) do
        for _, env in ipairs(parse_spec(pat)) do
          ---@diagnostic disable-next-line: undefined-global
          use(env)
        end
      end

      if is_bootstrap then
        require("packer").sync()
      end
    end,

    config = packer_opts,
  }
end

-- 〉

return { load = load }
