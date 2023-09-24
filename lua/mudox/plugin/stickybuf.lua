-- upstream: https://github.com/neovim/neovim/issues/12517

return {
  "stevearc/stickybuf.nvim",
  event = "VeryLazy",
  -- ISSUE: it causes telescope to open file in insert mode
  cond = false,
  opts = {},
}
