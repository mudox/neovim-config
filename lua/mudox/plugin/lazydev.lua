return {
  "folke/lazydev.nvim",
  dependencies = {
    "Bilal2453/luvit-meta",
    "justinsgithub/wezterm-types",
  },
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
