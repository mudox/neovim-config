local opts = {
  open_mapping = "<M-j>",

  shade_terminals = false,

  direction = "float",

  start_in_insert = true,

  highlights = {
    border = "FloatBorder",
    winblend = 0,
  },

  float_opts = {
    -- border = "curved",
  },
}

return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  opts = opts,
}
