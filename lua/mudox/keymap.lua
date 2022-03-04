--[==[
  utility lib for defining common mappings.

  the module provides 4 basic functions (map, cmd, plug, nop) all of which need a mode
  char as its 1st character

  by using metamethod `__index(tbl, name)` user can directly prefix the 4 methods
  with mode char

  by default all `noremap` option is enabled, `{ remap= true }` to disable it
  by default all `silent` option is enabled, `{ nosilent = true }` to disable it

  @usage: k.ncmd("<C-]>", [[echo "hello world"]])
]==]
local Set = require("pl.Set")
local modes = Set { "n", "i", "v", "o", "c", "s", "l", "t", "x" }

--[[
  the core method to define mapping. it calls `nvim_set_keymap` at last
]]
local function map(
  mode, -- mode char, see `:h map`
  from, -- key mapping string
  to, -- action string
  options -- see {opts} in `:h nvim_set_keymap()`
)
  options = options or {}

  -- eanble `noremap` by default
  if options.remap ~= true then
    options.noremap = true
  end
  options.remap = nil

  -- eanble `silent` by default
  if not options.nosilent ~= true then
    options.silent = true
  end
  options.nosilent = nil

  vim.api.nvim_set_keymap(mode, from, to, options)
end

--[[
  convenient method for common patter `<Cmd>...<Cr>`
]]
local function cmd(mode, from, to, options)
  map(mode, from, "<Cmd>" .. to .. "<Cr>", options)
end

--[[
  convenient method for common patter `<Plug>...`
]]
local function plug(mode, from, to, options)
  map(mode, from, ("<Plug>(%s)"):format(to), options)
end

--[[
  convenient method to clear mapping
]]
local function nop(mode, from)
  map(mode, from, "<Nop>", {})
end

local bodys = { map = map, cmd = cmd, plug = plug, nop = nop }

--[[
  compose mapping defining functions from parameter `name`.
  the 1st char in `name` is mode char, the remaining is one of string in `bodys` above

  @param name the name of the function invoked
  @return composed convenient mapping defining function
]]
local function parse(name)
  assert(type(name) == "string")

  -- mode char
  local mode = name:sub(1, 1)
  assert(modes[mode], ("invalid mode char `%s`"):format(mode))

  -- body method
  local body = name:sub(2)
  local fn = bodys[body]
  assert(fn, ("invalid body name `%s`"):format(body))

  return pl.func.bind1(fn, mode)
end

-- module

M = {}

for k, v in pairs(bodys) do
  M[k] = v
end

M.__index = function(tbl, name)
  local fn = parse(name)
  tbl[name] = fn
  return fn
end

setmetatable(M, M)

return M
