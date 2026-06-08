-- stylua: ignore
local function r(name) return require("mudox.plugin.snacks." .. name) end

local modules = {
  "picker",
  "toggle",
  "dashboard",
  "scratch",
}

local function init()
  for _, name in ipairs(modules) do
    if r(name).init then
      r(name).init()
    end
  end
end

local function keys()
  -- stylua: ignore
  local function k(c) return K.p"s" .. c end

  -- stylua: ignore
  local ret = {
    { k"\\",    function() Snacks.explorer() end,         desc = "file explorer"           },
    { K.p"o\\", function() Snacks.explorer() end,         desc = "file explorer"           },

    { K.p"ps",  function() Snacks.profiler.scratch() end, desc = "profiler scratch buffer" },
  }

  for _, name in ipairs(modules) do
    vim.list_extend(ret, r(name).keys or {})
  end

  return ret
end

local function opts()
  local ret = {
    styles = r("styles"),

    scratch = {},
    bigfile = {},
    input = {},
    quickfile = {},
    scope = {},

    zen = {
      -- stylua: ignore
      toggles = {
        dim             = false,
        git_signs       = true,
        mini_diff_signs = true,
      },
    },
  }

  for _, name in ipairs(modules) do
    ret[name] = r(name).opts
  end

  return ret
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 900,
  keys = keys,
  init = init,
  opts = opts,
}
