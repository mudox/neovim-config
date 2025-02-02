return {
  "folke/snacks.nvim",
  priority = 999,
  lazy = false,
  -- stylua: ignore
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile      = { enabled = true },
    notifier     = { enabled = false },
    quickfile    = { enabled = true },
    statuscolumn = { enabled = false },
    words        = { enabled = false },
    picker       = {},
  },
}
