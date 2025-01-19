-- stylua: ignore
local opts = {
  arguments     = { enable = false },
  group_names   = { icon   = "󰏗 "  },
  keycodes      = { enable = false },
  mention_links = { icon   = ""    },
  notes         = {
    default     = { icon   = "┃"   },
    warning     = { icon   = "┃"   },
    deprecated  = { icon   = "┃"   },
  },
  option_links  = { icon   = ""    },

  headings      = {
    heading_1   = { sign   = "󰎦 "  },
    heading_2   = { sign   = "󰎩 "  },
    heading_3   = { sign   = "󰎬 "  },
    heading_4   = { sign   = "󰎮 "  },
  },
}

return {
  -- "OXY2DEV/helpview.nvim",
  dir = "~/Git/neovim-plugins/helpview.nvim", -- HACK: `tbl_deep_extend` config
  ft = "help",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = opts,
}
