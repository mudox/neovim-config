-- check packer availability
local install_path = pl.path.join(stdpath.pack, 'packer/start/packer.nvim')
if not pl.path.exists(install_path) then
  print 'Installing packer.nvim ...'
  vim.fn.system(
      {
        'git',
        'clone',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
      }
  )
  vim.cmd 'packadd packer.nvim'
end

local function spec(name)
  local pat = pl.path.join(stdpath.luaplugin, name .. '.lua')
  local paths = vim.fn.glob(pat, false, true)
  assert(#paths > 0, 'invalid plugin spec pattern: ' .. pat)

  local envs = {}
  for _, path in ipairs(paths) do
    local env = {}
    setfenv(loadfile(path), env)()

    ---@diagnostic disable: undefined-field
    assert(type(env.url) == 'string', ('invalid `url` field in %s'):format(path))
    env[1] = env.url
    env.url = nil
    ---@diagnostic enable: undefined-field

    table.insert(envs, env)
  end

  return envs
end

local config = {
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'rounded'})
    end,
  },
}

--- @example: require('pluginmanager').load('plugins')
--- @example: require('pluginmanager').load('vscode.plugins')
local function load(path)
  require('packer').startup(
      {
        function()
          for _, pat in ipairs(require(path)) do
            for _, env in ipairs(spec(pat)) do
              use(env)
            end
          end
        end,
        config = config,
      }
  )
end

return {load = load}
