return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    integrations = {
      lspconfig = false,
      cmp = false,
      coq = false,
    },
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
