local main_key = require("mudox.keyboard").c["/"]

return {
  "numToStr/Comment.nvim",
  event = { "BufRead", "BufNewFile" },
  opts = {
    toggler = {
      line = main_key,
    },
  },
  keys = {
    { main_key, "gc", mode = "x", remap = true, desc = "Comment Selection" },
  },
}
