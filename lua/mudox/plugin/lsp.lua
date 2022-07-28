url = "williamboman/mason.nvim"

requires = {
  { "williamboman/mason-lspconfig.nvim", event = "BufRead" },
  { "neovim/nvim-lspconfig", event = "BufRead" },
}

event = "BufRead"

after = { "nvim-lspconfig", "cmp-nvim-lsp", "mason-lspconfig.nvim" }
