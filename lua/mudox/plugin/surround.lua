return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  opts = {
    keymaps = {
      visual = "gs", -- the default `S` conflicts with `leap.nvim`
      visual_line = "gS",
    },
  },
}
