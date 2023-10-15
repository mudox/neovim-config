--[==[
  Utility lib for defining common mappings.

  The module provides follow basic functions:
    - map     ->  vim.keymap.set(...)
    - cmd     ->  <Cmd>%s<Cr>
    - plug    ->  <Plug>(%s) with `remap` = true
    - nop     ->  <Nop>
    - call    ->  <Cmd>call %s
    - expr    ->  %s with `expr` = true
    - lua     ->  <Cmd>lua %s
    - req     ->  <Cmd>lua require(%s).%s<Cr>
  All of which need a map mode char as its 1st character (`help map-modes`).

  By default
    - remap = false (by default for `vim.keymap.set`)
    - silent = true if not in `c` mode

  @usage: k.ncmd("<C-]>", [[echo "hello world"]])
]==]

local Set = require("pl.Set")
local modes = Set { "n", "i", "v", "o", "c", "s", "l", "t", "x" }

--[[
  `vim.keymap.set` does not like unknown keys
--]]
local function normalize_options(mode, options)
  -- `remap` default `false` in `vim.keymap.set`

  -- `cmap` needs echoing (`silent = false` ) in most cases
  if options.silent == nil then
    options.silent = mode ~= "c"
  end

  return options
end

--[[
  the core method to define mapping. it calls `vim.keymap.set` at the end
]]
local function map(
  mode, -- mode char, see `:h map-modes` and `:h map-table`
  from, -- key mapping string
  to, -- ex-command string or lua function
  opts -- see {opts} in `:h nvim_set_keymap()`
)
  opts = opts or {}
  opts = normalize_options(mode, opts)

  vim.keymap.set(mode, from, to, opts)
end

local function expr(mode, from, to, opts)
  opts = opts or {}
  opts.expr = true
  opts.silent = false
  map(mode, from, to, opts)
end

--[[
  convenient method for common pattern `<Cmd>{ex command}<Cr>`
]]
local function cmd(mode, from, to, opts)
  to = "<Cmd>" .. to .. "<Cr>"
  opts = opts or {}

  -- if mode == "i" then
  --   to = "<Esc>" .. to
  -- elseif mode == "t" then
  --   to = "<C-\\><C-n>" .. to
  --   opts.remap = true
  -- end

  map(mode, from, to, opts)
end

--[[
  convenient method for common pattern `<Cmd>lua {lua code}<Cr>`
]]
local function lua(mode, from, to, options)
  map(mode, from, "<Cmd>lua " .. to .. "<Cr>", options)
end

--[[
  convenient method for common pattern `<Cmd>call {vim function}<Cr>`
]]
local function call(mode, from, to, options)
  map(mode, from, "<Cmd>call " .. to .. "<Cr>", options)
end

--[[
  convenient method for common pattern `<Plug>(...)`
  NOTE: parentheses are not added automatically
  ]]
local function plug(mode, from, to, options)
  options = options or {}
  options.remap = true
  map(mode, from, ("<Plug>%s"):format(to), options)
end

--[[
  convenient method for common pattern `<Cmd>lua require(...)...<Cr>`
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

function M.lazy_keys(tbl, opts)
  for _, v in pairs(tbl) do
    -- lhs
    if opts.key_prefix then
      local c1 = v[1]:sub(1, 1)
      if c1 ~= "<" and c1 ~= "-" then
        v[1] = opts.key_prefix .. v[1]
      end

      if c1 == "-" then
        v[1] = v[1]:sub(2)
      end
    end

    -- rhs
    if type(v[2] == "string") then
      if opts.main_cmd then
        v[2] = ("<Cmd>%s %s<Cr>"):format(opts.main_cmd, v[2])
      elseif opts.cmd_prefix then
        v[2] = ("<Cmd>%s%s<Cr>"):format(opts.cmd_prefix, v[2])
      elseif opts.cmd_fmt then
        v[2] = (opts.cmd_fmt):format(v[2])
      end
    end

    -- desc
    v.desc = v[3]
    v[3] = nil
    if opts.desc_prefix then
      v.desc = ("[%s] %s"):format(opts.desc_prefix, v.desc)
    end
  end

  return tbl
end

return M
