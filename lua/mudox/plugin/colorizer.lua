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
  keys = {
    { "coc", "<Cmd>ColorizerToggle<Cr>", desc = "[Colorizer] Toggle" },
  },
  opts = opts,
}
