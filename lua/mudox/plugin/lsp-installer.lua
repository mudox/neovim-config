url = "williamboman/nvim-lsp-installer"

requires = {
  { "neovim/nvim-lspconfig", event = "BufferRead" },
}

event = "BufferRead"

after = "nvim-lspconfig"
