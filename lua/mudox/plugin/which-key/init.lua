-- stylua: ignore
-- appand `en space` to prevent trimming
local keys = {
  Up              = "󰁝",
  Down            = "󰁅",
  Left            = "󰁍",
  Right           = "󰁔",
  C               = "󰘳 ",
  M               = "󰘴 ",
  S               = "󰘶 ",
  CR              = " ",
  Esc             = "󱊷 ",
  ScrollWheelDown = "󱕐 ",
  ScrollWheelUp   = "󱕑 ",
  NL              = " ",
  BS              = "󰭜 ",
  Space           = "󱁐 ",
  Tab             = "󰌒 ",
}

local opts = {
  notify = false,

  -- ui
  show_help = true,
  show_keys = true,
  icons = {
    breadcrumb = require("mudox.ui.icon").chevron.right,
    separator = "  ",
    group = " ",
    mappings = false, -- remove keymap icons
    keys = keys,
  },

  -- keymaps
  spec = require("mudox.plugin.which-key.root"),
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = opts,
}
