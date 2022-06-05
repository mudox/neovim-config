--[==[
  Utility lib for defining common mappings.

  The module provides follow basic functions:
    - map
    - cmd     ->  <Cmd>%s<Cr>
    - plug    ->  <Plug>(%s) with `remap` = true
    - nop     ->  <Nop>
    - lua     ->  <Cmd>lua %s
    - call    ->  <Cmd>call %s
    - expr    ->  %s with `expr` = true
    - req     ->  <Cmd>lua require(%s).%s<Cr>
  All of which need a map mode char as its 1st character (`help map-modes`).

  By default
    - remap = false
    - silent = true

  @usage: k.ncmd("<C-]>", [[echo "hello world"]])
]==]

local Set = require("pl.Set")
local modes = Set { "n", "i", "v", "o", "c", "s", "l", "t", "x" }

--[[
  `vim.keymap.set` does not like unknown keys
--]]
local function normalize_options(options)
  local opts = options

  if opts.silent == nil then
    opts.silent = true
  end

  return opts
end

--[[
  the core method to define mapping. it calls `vim.keymap.set` at the end
]]
local function map(
  mode, -- mode char, see `:h map-modes` and `:h map-table`
  from, -- key mapping string
  to, -- ex-command string or lua function
  options -- see {opts} in `:h nvim_set_keymap()`
)
  options = options or {}

  vim.keymap.set(mode, from, to, normalize_options(options))
end

local function expr(mode, from, to, opts)
  opts = opts or {}
  opts.expr = true
  opts.silent = false
  map(mode, from, to, opts)
end

--[[
  convenient method for common patter `<Cmd>{ex command}<Cr>`
]]
local function cmd(mode, from, to, options)
  map(mode, from, "<Cmd>" .. to .. "<Cr>", options)
end

--[[
  convenient method for common patter `<Cmd>lua {lua code}<Cr>`
]]
local function lua(mode, from, to, options)
  map(mode, from, "<Cmd>lua " .. to .. "<Cr>", options)
end

--[[
  convenient method for common patter `<Cmd>call {vim function}<Cr>`
]]
local function call(mode, from, to, options)
  map(mode, from, "<Cmd>call " .. to .. "<Cr>", options)
end

--[[
  convenient method for common patter `<Plug>(...)`
  NOTE: parentheses are not added automatically
  ]]
local function plug(mode, from, to, options)
  options = options or {}
  options.remap = true
  map(mode, from, ("<Plug>%s"):format(to), options)
end

--[[
  convenient method for common patter `<Cmd>lua require(...)...<Cr>`
]]
local function req(mode, from, module, to, options)
  map(mode, from, ("<Cmd>lua require('%s').%s<Cr>"):format(module, to), options)
end

--[[
  convenient method to clear mapping
]]
local function nop(mode, from, options)
  map(mode, from, "<Nop>", options)
end

local bodys = {
  map = map,
  cmd = cmd,
  plug = plug,
  nop = nop,
  lua = lua,
  call = call,
  expr = expr,
  req = req,
}

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
