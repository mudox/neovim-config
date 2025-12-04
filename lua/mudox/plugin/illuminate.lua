local allowlist = {
  "c",
  "cpp",
  "javascript",
  "lua",
  "python",
  "rust",
  "swift",
  "typescript",
  "lua",
}

local opts = {
  providers = {
    "lsp",
    "treesitter",
    "regex",
  },

  filetypes_denylist = {}, -- for `allowlist` to take effect
  filetypes_allowlist = allowlist,

  modes_denylist = {},
  modes_allowlist = { "n" },

  delay = 200,
  under_cursor = false,
  min_count_to_highlight = 2,

  large_file_cutoff = 300,
  large_file_overrides = {
    providers = {
      "lsp",
      "regex",
    },
  },
}

local nav = {
  name = "illuminate",
  left = function()
    require("illuminate").goto_prev_reference(true)
    vim.cmd.normal({ "zv", bang = true })
  end,
  right = function()
    require("illuminate").goto_next_reference(true)
    vim.cmd.normal({ "zv", bang = true })
  end,
}

return {
  "RRethy/vim-illuminate",
  event = { "BufRead", "BufNewFile" },
  keys = {
    { "]r", X.arrows.right(nav), desc = "[illuminate] reference" },
    { "[r", X.arrows.left(nav), desc = "[illuminate] reference" },
  },
  config = function()
    require("illuminate").configure(opts)
  end,
}
