local function config()
  local i = require("mudox.ui").icons
  local icons = {
    ERROR = i.error,
    WARN = i.warn,
    INFO = i.info,
    DEBUG = i.debug,
    TRACE = i.trace,
  }

  -- TODO: review notify options
  local opts = {
    stages = "static",

    on_open = nil,
    on_close = nil,

    render = "default",

    timeout = 5000,

    max_width = nil,
    max_height = nil,
    minimum_width = 50,

    icons = icons,
  }

  local notify = require("notify")
  notify.setup(opts)
  vim.notify = notify
end

local keys = {
  {
    "<leader>un",
    function()
      require("notify").dismiss { silent = true, pending = true }
    end,
    desc = "Dismiss all notifications",
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
