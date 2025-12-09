return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = vim.env.VIMRUNTIME, words = { "vim" } },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
