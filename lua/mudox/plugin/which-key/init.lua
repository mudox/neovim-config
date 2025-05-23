-- stylua: ignore
-- appand `en space` to prevent trimming
local key_icons = {
  Up              = "󰁝",
  Down            = "󰁅",
  Left            = "󰁍",
  Right           = "󰁔",
  C               = "󰘳 ",
  M               = "󰘴 ",
  S               = "󰘶 ",
  CR              = "󰌑 ",
  Esc             = "󱊷 ",
  ScrollWheelDown = "󱕐 ",
  ScrollWheelUp   = "󱕑 ",
  NL              = "␤ ",
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
    breadcrumb = I.chevron.right,
    separator = "  ",
    group = "+",
    mappings = false, -- remove keymap icons
    keys = key_icons,
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
