--[[
  plugin spec DSL
  - `specs`: array
    spec names relative to `stdpath('config')/lua/plugin` without `.lua` extenion
  - `spec_groups`: array
    spec group names (folders) relative to `stdpath('config')/lua/plugin/`
  
  spec DSL
  - `install`: string
    One or more `Plug` command lines to install plugins
  - `setup`: function
    plugin configration code with conveniences avaialbe for configuring
    + key map helpers from `keymap.lua`
    + vim lua stdlib from `_G`
    + set vim globals via `g` table
    more to be added later
    + set vim global options via `o` table
]] --- @module plug
local plug = {}

local utils = require('pl.utils')
local path = require('pl.path')
local tablex = require('pl.tablex')
local glob = require('posix.glob')
local _ = require('moses').chain
local x = require('inspect')

local setups = {}

local function make_env()

  local env = tablex.copy(_G)
  utils.import(require('keymap'), env)
  setmetatable(env, {__index = require('keymap')})

  -- vim `g:` varaibles
  env.g = {}
  setmetatable(env.g, {__index = vim.g})

  -- vim global options
  env.o = {}
  setmetatable(env.o, {__index = vim.o})

  return env
end

local function do_setups()
  for id, setup in pairs(setups) do
    local env = make_env()
    setfenv(setup, env)()

    -- vim global variables
    tablex.update(vim.g, env.g)
    tablex.update(vim.o, env.o)

    -- vim global options
  end
end

-- paramter `group` should be relative to `stdpath('config')/lua/plugin`
-- return list of string with prefix `<group>/xxx` for `loadfile`

local function glob_spec_group(group)
  local pat = path.join(vim.fn.stdpath('config'), 'lua/plugin', group, '*.lua')

  local files = glob.glob(pat, 0)
  -- local files = vim.fn.glob(pat, true, true)

  if type(files) ~= 'table' then
    -- maybe empty
    return {}
  end

  return _(files):map(function(p)
    local name = path.basename(path.splitext(p))
    return path.join(group, name)
  end):value()
end

local function start()
  vim.cmd [[call plug#begin(stdpath('data') . '/plugged')]]
end

local function done()
  vim.call 'plug#end'

  do_setups()
end

local function load_spec(name)
  -- print('load spec: ' .. name)
  local dir = path.join(vim.fn.stdpath('config'), 'lua/plugin/', name)
  local fn = loadfile(dir .. '.lua')

  local env = {}
  setfenv(fn, env)()

  assert(type(env.install) == 'string')
  vim.cmd(env.install)

  if type(env.setup) == 'function' then
    setups[name] = env.setup
  end
end

local function load_specs(specs)
  for _, spec in ipairs(specs) do
    load_spec(spec)
  end
end

local function load_spec_groups(list)
  for _, group_name in ipairs(list) do
    load_specs(glob_spec_group(group_name))
  end
end

--
-- public
--

function plug.load(dsl_name)
  start()

  local dsl_path = path.join(vim.fn.stdpath('config'), 'lua', dsl_name) ..
                       '.lua'
  local fn = loadfile(dsl_path)

  local env = {}
  setfenv(fn, env)()

  if type(env.specs) == 'table' then
    load_specs(env.specs)
  end

  if type(env.spec_groups) == 'table' then
    load_spec_groups(env.spec_groups)
  end

  done()
end

return plug
