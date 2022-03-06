url = "williamboman/nvim-lsp-installer"

requires = {
  { "neovim/nvim-lspconfig" },
}

event = "BufRead"

after = "nvim-lspconfig"
