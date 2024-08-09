local views = {
  cmdline_popup = {
    border = {
      style = "single",
    },
  },
  popupmenu = {
    border = {
      style = "none",
    },
  },
}

local routes = {
  -- remove 'written' messages
  {
    filter = {
      event = "msg_show",
      kind = "",
      find = "written",
    },
    opts = { skip = true },
  },
  -- {
  --   filter = {
  --     any = {
  --       {
  --         event = "msg_show",
  --         min_height = 15,
  --       },
  --       {
  --         event = "msg_show",
  --         min_width = 30,
  --       },
  --     },
  --   },
  --   view = "split",
  -- },
}

local cmdline = {
  format = {
    cmdline = { pattern = "^:", icon = "", lang = "vim" },
    search_down = { kind = "search", pattern = "^/", icon = " 󰅀", lang = "regex" },
    search_up = { kind = "search", pattern = "^%?", icon = " 󰅃", lang = "regex" },
    filter = { pattern = "^:%s*!", icon = " ", lang = "bash" },
    help = { pattern = "^:%s*he?l?p?%s+", icon = "󰌵" },
  },
}

local lsp = {
  -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  override = {
    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    ["vim.lsp.util.stylize_markdown"] = true,
    ["cmp.entry.get_documentation"] = true,
  },
}

local opts = {
  views = views,
  routes = routes,

  cmdline = cmdline,
  lsp = lsp,

  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
}

-- stylua: ignore start

local keys = {
  { "<leader>tN",       "<Cmd>Noice telescope<Cr>", desc = "[Noice] History in telescope" },
  { "<leader>m<Space>", "<Cmd>Noice<Cr>",           desc = "[Noice] History"              },
  { "<leader>m.",       "<Cmd>Noice last<Cr>",      desc = "[Noice] Last message"         },
  { "<leader>me",       "<Cmd>Noice errors<Cr>",    desc = "[Noice] Errors"               },
  { "<leader>m[",       "<Cmd>Noice disable<Cr>",   desc = "[Noice] Disable"              },
  { "<leader>m]",       "<Cmd>Noice enable<Cr>",    desc = "[Noice] Enable"               },
}

-- stylua: ignore end

return {
  cond = false,
  "folke/noice.nvim",
  dependencies = {
    "nui.nvim",
    "nvim-notify",
  },
  event = "VeryLazy",
  keys = keys,
  opts = opts,
  config = function(_, o)
    require("noice").setup(o)

    -- completely hide statusline
    vim.cmd([[
      set laststatus=0
      hi! link StatusLine WinSeparator
      hi! link StatusLineNC WinSeparator
      set statusline=%{repeat('─',winwidth('.'))}
    ]])
  end,
}
