return {
  -- "SmiteshP/nvim-navbuddy", -- origin
  "hasansujon786/nvim-navbuddy",
  dependencies = {
    "Comment.nvim",
    "nui.nvim",
    "nvim-lspconfig",
    "nvim-navic",
    "telescope.nvim",
  },
  event = { "BufRead", "BufNewFile" },
  cmd = "Navbuddy",
  keys = {
    { "<C-;>", "<Cmd>Navbuddy<Cr>", desc = "Navbuddy" },
  },
  opts = {
    window = { border = "none" },
    lsp = { auto_attach = true },
    icons = I.kind,
    node_markers = { enabled = false },
  },
}
