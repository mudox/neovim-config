local function opts()
  local i = I.diagnostic.cod
  -- stylua: ignore
  local icons = {
    ERROR = i.error,
    WARN  = i.warn,
    INFO  = i.info,
    DEBUG = i.debug,
    TRACE = i.trace,
  }

  return {
    -- top_down = true,
    -- render = "default",
    icons = icons,
    stages = "static",
    timeout = 5000,

    on_open = function(win)
      vim.api.nvim_win_set_config(win, {
        -- border = I.border.box,
        border = "single", -- 'rounded' by default
      })
    end,
    on_close = nil,

    max_width = 70,
    minimum_width = 47,
    max_height = 12,

    -- render = "wrapped-compact",
  }
end

local function config()
  local m = require("notify")

  m.setup(opts())
  vim.notify = m
end

local function dismiss_all()
  require("notify").dismiss { silent = true, pending = true }
end

-- stylua: ignore
local keys = {
  { "<Bs>n",      dismiss_all,                 desc = "[Notify] Dismiss all",     },
  { "<leader>tn", "<Cmd>Telescope notify<Cr>", desc = "[Telescope] Notifications" },
  { "<leader>vv", "<Cmd>Notifications<Cr>",    desc = "Notify notifications"    },
}

return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = config,
  keys = keys,
  -- init = function()
  --   -- when noice is not enabled, install notify on verylazy
  --   local util = require("lazyvim.util")
  --   if not util.has("noice.nvim") then
  --     util.on_very_lazy(function()
  --       vim.notify = require("notify")
  --     end)
  --   end
  -- end,
}
