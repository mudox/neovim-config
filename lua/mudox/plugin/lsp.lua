url = "williamboman/nvim-lsp-installer"

requires = {
  { "neovim/nvim-lspconfig", event = "BufRead" },
}

event = "BufRead"

after = "nvim-lspconfig"
