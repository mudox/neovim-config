return {
  "christoomey/vim-tmux-navigator",
  -- event = "VeryLazy",
  -- stylua: ignore
  keys = {
    { "<C-h>", "<Cmd>TmuxNavigateLeft<Cr>",  desc = "[TmuxNav] Go left" },
    { "<C-l>", "<Cmd>TmuxNavigateRight<Cr>", desc = "[TmuxNav] Go right" },
    { "<C-j>", "<Cmd>TmuxNavigateDown<Cr>",  desc = "[TmuxNav] Go down" },
    { "<C-k>", "<Cmd>TmuxNavigateUp<Cr>",    desc = "[TmuxNav] Go up" },
  },
  init = function()
    -- vim.go.shell = "/bin/bash -i" -- PERF: faster

    vim.g.tmux_navigator_disable_when_zoomed = 1
    vim.g.tmux_navigator_no_mappings = 1
  end,
  -- cond = function()
  --   return vim.env.TMUX ~= nil
  -- end,
  cond = false,
}
