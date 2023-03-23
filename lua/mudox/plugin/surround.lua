return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  opts = {
    keymaps = {
      visual = ",s", -- `S` and `gs` conflicts with `leap.nvim`
      visual_line = ",S",
    },
  },
}
