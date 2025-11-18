-- stylua: ignore
-- appand `en space` to prevent trimming
local key_icons = {
  Up    = "󰁝",
  Down  = "󰁅",
  Left  = "󰁍",
  Right = "󰁔",

  C     = "C-",
  M     = "M-",
  S     = "S-",

  CR    = "Cr",
  Esc   = "Esc",
  NL    = "C-j",
  BS    = "Bs",
  Space = "Spc",
  Tab   = "Tab ",

  F1    = "F1",
  F2    = "F2",
  F3    = "F3",
  F4    = "F4",
  F5    = "F5",
  F6    = "F6",
  F7    = "F7",
  F8    = "F8",
  F9    = "F9",
  F10   = "F10",
  F11   = "F11",
  F12   = "F12",
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

  disable = {
    ft = {
      "TelescopePrompt", -- cause severe perf issue
      "dropbar_menu",
    },
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
