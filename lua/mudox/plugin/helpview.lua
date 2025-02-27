-- stylua: ignore
local opts = {
  vimdoc = {
  keycodes      = { default = { enable = false } },
  arguments     = { default = { enable = false } },
  mention_links = { default = { icon   = ""    } },
  notes         = {
    default     = { icon   = "┃"   },
    warning     = { icon   = "┃"   },
    deprecated  = { icon   = "┃"   },
  },
  },
  group_names   = { icon   = "󰏗 "  },
  option_links  = { icon   = ""    },

  -- headings      = {
  --   heading_1   = { sign   = "󰎦 "  },
  --   heading_2   = { sign   = "󰎩 "  },
  --   heading_3   = { sign   = "󰎬 "  },
  --   heading_4   = { sign   = "󰎮 "  },
  -- },
}

return {
  "OXY2DEV/helpview.nvim",
  -- dir = "~/Git/neovim-plugins/helpview.nvim", -- HACK: `tbl_deep_extend` config
  ft = "help",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = opts,
}
