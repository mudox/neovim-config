local opts = {
  sign = {
    enabled = false,
  },
  virtual_text = {
    enabled = true,
  },
  autocmds = {
    enabled = true,
    events = { "CursorHold" },
  },
}

return {
  "kosayoda/nvim-lightbulb",
  event = "VeryLazy",
  opts = opts,
}
