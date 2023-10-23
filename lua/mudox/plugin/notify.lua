local function config()
  local i = require("mudox.ui.icon")
  local icons = {
    ERROR = i.error,
    WARN = i.warn,
    INFO = i.info,
    DEBUG = i.debug,
    TRACE = i.trace,
  }

  -- TODO: review notify options
  local opts = {
    -- stages = "static",

    -- render = "default",

    on_open = function(win)
      vim.api.nvim_win_set_config(win, {
        -- border = require("mudox.ui.icon").border.box,
        border = "single", -- 'rounded' by default
      })
    end,
    on_close = nil,

    timeout = 5000,

    max_width = 70,
    minimum_width = 47,
    max_height = 16,

    icons = icons,
  }

  local notify = require("notify")
  notify.setup(opts)
  vim.notify = notify
end

local keys = {
  {
    "<leader>wN",
    function()
      require("notify").dismiss { silent = true, pending = true }
    end,
    desc = "[Notify] Dismiss all",
  },
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
