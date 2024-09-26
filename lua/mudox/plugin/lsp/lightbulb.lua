local opts = {
  sign = {
    enabled = false,
  },
  virtual_text = {
    enabled = true,
    -- text = "💡",
    text = "󰛕",
    -- text = " ",
  },
  autocmd = {
    enabled = true,
    events = { "CursorHold" },
  },
}

return {
  -- "kosayoda/nvim-lightbulb",
  "traap/nvim-lightbulb",
  event = "LspAttach",
  opts = opts,
}
