---Utility lib for defining keymaps.
---
---Base helper functions:
---  - map     ->  vim.keymap.set(...)
---  - cmd     ->  <Cmd>%s<Cr>
---  - plug    ->  <Plug>%s with `remap` = true
---  - nop     ->  <Nop>
---  - call    ->  <Cmd>call %s<Cr>
---  - expr    ->  %s with `expr` = true
---  - lua     ->  <Cmd>lua %s<Cr>
---  - req     ->  <Cmd>lua require(%s).%s<Cr>
---All of which need a map mode char as its 1st character (`help map-modes`).
---
---Defaults:
---  - remap = false (by default for `vim.keymap.set`), true for `plug`
---  - silent = true if not in `c` mode

---Fix opts
---`vim.keymap.set` does not like unknown keys
local function normalize_opts(mode, opts)
  -- `remap` default `false` in `vim.keymap.set`

  -- `cmap` needs echoing (`silent = false` ) in most cases
  if opts.silent == nil then
    opts.silent = mode ~= "c"
  end

  return opts
end

local bodys = {}

---The foundation method. it calls `vim.keymap.set` at the end
---@param mode string|string[] Mode character(s), see help of `map-modes`
---@param from string          Keymap string, see help `key-notation`
---@param to   string|function Normal command string or lua function
---@param opts table           opts, see help of `vim.keymap.set()`
function bodys.map(mode, from, to, opts)
  opts = opts or {}
  opts = normalize_opts(mode, opts)

  vim.keymap.set(mode, from, to, opts)
end

function bodys.expr(mode, from, to, opts)
  opts = opts or {}
  opts.expr = true
  opts.silent = false
  bodys.map(mode, from, to, opts)
end

---For pattern `<Cmd>{ex command}<Cr>`
function bodys.cmd(mode, from, to, opts)
  to = "<Cmd>" .. to .. "<Cr>"
  opts = opts or {}

  -- if mode == "i" then
  --   to = "<Esc>" .. to
  -- elseif mode == "t" then
  --   to = "<C-\\><C-n>" .. to
  --   opts.remap = true
  -- end

  bodys.map(mode, from, to, opts)
end

---For pattern `<Cmd>lua {lua code}<Cr>`
function bodys.lua(mode, from, to, opts)
  bodys.map(mode, from, "<Cmd>lua " .. to .. "<Cr>", opts)
end

---For pattern `<Cmd>call {vim function}<Cr>`
function bodys.call(mode, from, to, opts)
  bodys.map(mode, from, "<Cmd>call " .. to .. "<Cr>", opts)
end

---For pattern  `<Plug>xxx` or `<Plug>(xxx)`
---Note: Parentheses are not added automatically
function bodys.plug(mode, from, to, opts)
  opts = opts or {}
  opts.remap = true
  bodys.map(mode, from, ("<Plug>%s"):format(to), opts)
end

---For pattern `<Cmd>lua require(...)...<Cr>`
function bodys.req(mode, from, module, to, opts)
  bodys.map(mode, from, ("<Cmd>lua require('%s').%s<Cr>"):format(module, to), opts)
end

---Clear mapping
function bodys.nop(mode, from, opts)
  bodys.map(mode, from, "<Nop>", opts)
end

local modes = {
  n = true,
  i = true,
  v = true,
  o = true,
  c = true,
  s = true,
  l = true,
  t = true,
  x = true,
}

---Compose mapping defining functions from parameter `name`.
---
---The 1st char in `name` is mode char, the remaining is one of keys in `bodys` above
---
---@param name string The name of the function invoked
---@return function Composed convenient mapping defining function
local function get(name)
  assert(type(name) == "string")

  -- mode char
  local mode = name:sub(1, 1)
  assert(modes[mode], ("invalid mode char `%s`"):format(mode))

  -- body method
  local body = name:sub(2)
  local fn = bodys[body]
  assert(fn, ("invalid body name `%s`"):format(body))

  return function(...)
    fn(mode, ...)
  end
end

local M = vim.deepcopy(bodys)

setmetatable(M, {
  __index = function(t, name)
    local fn = get(name)
    t[name] = fn
    return fn
  end,
})

function M.lazy_keys(tbl, opts)
  local function skip(v, i)
    if type(v[i]) == "string" and v[i]:sub(-4) == " ✓" then
      v[i] = v[i]:sub(1, -5)
      return true
    else
      return false
    end
  end

  local function lhs(v)
    if v.mode ~= nil or skip(v, 1) then
      return
    end

    if opts.key_prefix then
      v[1] = opts.key_prefix .. v[1]
    end
    v.l = nil
  end

  local function rhs(v)
    if skip(v, 2) then
      return
    end

    if type(v[2]) == "string" then
      if opts.main_cmd then
        v[2] = ("<Cmd>%s %s<Cr>"):format(opts.main_cmd, v[2])
      elseif opts.cmd_prefix then
        v[2] = ("<Cmd>%s%s<Cr>"):format(opts.cmd_prefix, v[2])
      elseif opts.cmd_fmt then
        v[2] = (opts.cmd_fmt):format(v[2])
      end
    end
  end

  local function desc(v)
    v.desc = v[3]
    v[3] = nil

    if skip(v, "desc") then
      return
    end

    if opts.desc_prefix and v.desc:sub(1, 1) ~= "[" then
      v.desc = ("[%s] %s"):format(opts.desc_prefix, v.desc)
    end
  end

  for _, v in pairs(tbl) do
    lhs(v)
    rhs(v)
    desc(v)
  end

  return tbl
end

return M
