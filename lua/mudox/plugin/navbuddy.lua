return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "nvim-navic",
    "neovim/nvim-lspconfig",
    "MunifTanjim/nui.nvim",
    "numToStr/Comment.nvim",
    "nvim-telescope/telescope.nvim",
  },
  event = { "BufRead", "BufNewFile" },
  keys = {
    { "<M-i>", "<Cmd>Navbuddy<Cr>", desc = "Navbuddy" },
  },
  opts = {
    lsp = { auto_attach = true },
    icons = require("mudox.ui").icons.kind,
  },
}
