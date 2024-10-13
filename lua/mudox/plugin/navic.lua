return {
  "SmiteshP/nvim-navic",
  event = { "BufRead", "BufNewFile" },
  opts = {
    lsp = { auto_attach = true },
    icons = I.kind,
  },
}
