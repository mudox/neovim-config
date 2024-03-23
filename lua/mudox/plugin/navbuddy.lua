return {
  "SmiteshP/nvim-navbuddy",
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
    icons = require("mudox.ui.icon").kind,
    node_markers = { enabled = false },
  },
}
