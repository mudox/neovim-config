local opts = {
  filetypes = {
    "css",
    "javascript",
    "lua",
    html = { mode = "foreground" },
  },
}

return {
  "NvChad/nvim-colorizer.lua",
  cmd = { "ColorizerToggle" },
  opts = opts,
}
