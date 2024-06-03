return {
  "christoomey/vim-tmux-navigator",
  -- event = "VeryLazy",
  keys = { "<C-l>", "<C-h>", "<C-j>", "<C-j>" },
  init = function()
    vim.g.tmux_navigator_disable_when_zoomed = 1
  end,
}
