return {
  "SmiteshP/nvim-navic",
  event = { "BufRead", "BufNewFile" },
  opts = {
    lsp = { auto_attach = true },
    icons = require("mudox.ui.icon").kind,
  },
}
