return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    diagnostics = {
      globals = { "vim", "Snacks" },
    },
    library = {
      { path = vim.env.VIMRUNTIME, words = { "vim" } },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
