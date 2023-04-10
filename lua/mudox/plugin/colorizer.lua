local opts = {
  filetypes = {
    "css",
    "javascript",
    "lua",
    html = { mode = "foreground", }
  },
}

return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufRead", "BufNewFile" },
  opts = opts,
}
