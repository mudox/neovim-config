-- stylua: ignore
local function r(name) return require("mudox.plugin.snacks." .. name) end

local mods = { "picker", "toggle" }

local function init()
  for _, name in ipairs(mods) do
    if r(name).init then
      r(name).init()
    end
  end
end

local function keys()
  -- stylua: ignore
  local function k(c) return "<leader>s" .. c end

  -- stylua: ignore
  local ret = {
    { k"\\",            function() Snacks.explorer() end,               desc = "File explorer"           },
    { "<leader>fl",     function() Snacks.explorer() end,               desc = "File explorer"           },
    -- { "<C-S-p>",        function() Snacks.explorer() end,               desc = "File explorer"           },

    { "<leader>ps",     function() Snacks.profiler.scratch() end,       desc = "Profiler scratch buffer" },
  }

  for _, name in ipairs(mods) do
    vim.list_extend(ret, r(name).keys or {})
  end

  return ret
end

local function opts()
  local ret = {
    bigfile = {},
    dashboard = {
      enabled = true,
      preset = {
        header = U.logo(),
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
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
