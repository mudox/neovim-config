return {
  "numToStr/Comment.nvim",
  event = { "BufRead", "BufNewFile" },
  opts = {
    toggler = {
      line = "<C-/>",
    },
  },
  keys = {
    { "<C-/>", "gc", mode = "x", remap = true, desc = "Comment Selection" },
  },
}
