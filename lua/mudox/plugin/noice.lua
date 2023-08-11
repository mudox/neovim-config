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
  cmdline = cmdline,
  lsp = lsp,
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}

return {
  "folke/noice.nvim",
  dependencies = {
    "nui.nvim",
    "nvim-notify",
  },
  -- cond = false,
  event = "VeryLazy",
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
