-- vim: fdm=marker fmr=〈,〉
local p = pl.path

-- Bootstrap 〈
local is_bootstrap = false
if not p.exists(stdpath.packer_install) then
  print 'Installing packer.nvim ...'
  is_bootstrap = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    stdpath.packer_install,
  })
end
-- 〉

--- if `config` is missing in plugin spec file and there is a <name>.{lua,vim} file under
-- lua/plugin/config folder, construct a `config` function to `require/source` this file
local function config_function(path)
  local name = p.basename(p.splitext(path))

  local luaFile = ('%s/%s.lua'):format(stdpath.lua_plugin_config, name)
  if p.isfile(luaFile) then
    local code = ([[
      require 'plugin.config.%s'
    ]]):format(name, name)

    return load(code)
  end

  local vimFile = ('%s/%s.vim'):format(stdpath.lua_plugin_config, name)
  if p.isfile(vimFile) then
    local code = ([[
      vim.cmd('source %s')
    ]]):format(vimFile)

    return load(code)
  end
end

local function spec(pattern)
  local pat = p.join(stdpath.lua_plugin, pattern .. '.lua')
  local paths = vim.fn.glob(pat, false, true)
  assert(#paths > 0, 'invalid plugin spec pattern: ' .. pat)

  local envs = {}
  for _, path in ipairs(paths) do
    local chunk = loadfile(path)
    assert(chunk, 'invalid spec path: ' .. path)

    local env = {}
    ---@diagnostic disable-next-line: deprecated
    setfenv(chunk, env)()

    -- url
    assert(type(env.url) == 'string', ('invalid `url` field in %s'):format(path))
    env[1] = env.url
    env.url = nil

    -- config
    env.config = env.config or config_function(path)

    table.insert(envs, env)
  end

  return envs
end

-- Config packer 〈

local config = {
  -- mode separation
  package_root = stdpath.pack,
  compile_path = stdpath.packer_compiled,
  -- appearence
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'solid'})
    end,
  },
}

-- 〉

--- @example: require('pluginmanager').load(stdpath('plugins'))
local function load(path)
  require('packer').startup({
    function()
      for _, pat in ipairs(require(path)) do
        for _, env in ipairs(spec(pat)) do
          ---@diagnostic disable-next-line: undefined-global
          use(env)
        end
      end

      if is_bootstrap then
        require('packer').sync()
      end
    end,
    config = config,
  })
end

return {load = load}
