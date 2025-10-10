-- stylua: ignore
local function r(name) return require("mudox.plugin.snacks." .. name) end

local mods = { "picker", "toggle", "dashboard", "scratch" }

local function init()
  for _, name in ipairs(mods) do
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
    { k"\\",        function() Snacks.explorer() end,         desc = "File explorer"           },
    { K.p"fl", function() Snacks.explorer() end,         desc = "File explorer"           },
    -- { "<C-S-p>",        function() Snacks.explorer() end,               desc = "File explorer"           },

    { K.p"ps", function() Snacks.profiler.scratch() end, desc = "Profiler scratch buffer" },

  }

  for _, name in ipairs(mods) do
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
  }

  for _, name in ipairs(mods) do
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
