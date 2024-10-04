local log = require("plenary.log").new {
  plugin = "swizzle",
  use_console = false,
  level = "debug",
}

local function get_plugin(path)
  return path:match("share/nvim/lazy/([^/]+)/(.*)")
end

---@class mudox.swizzle.context
---@field fn string function name
---@field path string full pathname
---@field line number line number
---@field plugin string plugin name
---@field rpath string relative path under the plugin dir

---Parse debug.traceback
---@param n integer stack level to begin with
---@return mudox.swizzle.context
local function parse(n)
  local trace = debug.traceback("", n)

  local r = {}
  for line in trace:gmatch("[^\r\n]+") do
    local path, ln, fn = vim.fn.trim(line):match("([^:]+):(%d+):.*in function '([^']+)'")
    if path then
      path = vim.fn.fnamemodify(path, ":p")
      local plugin, tail = get_plugin(path)
      table.insert(r, {
        path = path,
        line = ln,
        fn = fn,
        plugin = plugin,
        rpath = tail,
      })
    end
  end

  return r
end

local handlers = {}

---Router
---@param info [mudox.swizzle.context] parsed traceback
---@param orig fun(...):number the original `vim.api.nvim_open_win`
---@param args table args passed to call `orig`
---@return number winnr from calling `orig`
local function route(info, orig, args)
  for _, fn in ipairs(handlers) do
    local r = fn(info, orig, args)
    if r then
      return r
    end
  end

  return orig(unpack(args))
end

-- conform.nvim
table.insert(handlers, function(info, orig, args)
  local r = vim.tbl_contains(info, function(v)
    return v.plugin == "conform.nvim"
  end, { predicate = true })
  if r then
    args[3] = vim.tbl_deep_extend("force", args[3], {
      border = "none",
      col = 5,
      row = 4,
      width = vim.o.columns - 10,
      height = vim.o.lines - 12,
    })
    return orig(unpack(args))
  else
    return false
  end
end)

return function()
  vim.api.nvim_open_win = (function(orig)
    return function(buf, enter, opts)
      if opts.relative ~= "" then
        local x = parse(3)
        log.debug(vim.inspect(x))
        return route(x, orig, { buf, enter, opts or {} })
      else
        return orig(buf, enter, opts)
      end
    end
  end)(vim.api.nvim_open_win)
end
