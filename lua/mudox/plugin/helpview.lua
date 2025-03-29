-- stylua: ignore
local opts = {
  vimdoc = {
    headings         = {
      heading_1      = { sign = " 1 ", },
      heading_2      = { sign = " 2 ", },
      heading_3      = { sign = " 3 ", },
      heading_4      = { sign = " 4 ", },
    },
    keycodes         = { default = { enable = false } },
    arguments        = { default = { enable = false } },
    mention_links    = { default = { icon   = ""    } },
    notes            = {
      default        = { icon   = "┃"   },
      warning        = { icon   = "┃"   },
      deprecated     = { icon   = "┃"   },
    },
    optionlinks      = { icon   = ""    },
    highlight_groups = { icon   = "󰏗 "  },
    },
}

return {
  "OXY2DEV/helpview.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  opts = opts,
}
