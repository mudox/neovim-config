return {
  "zeioth/garbage-day.nvim",
  dependencies = "nvim-lspconfig",
  event = "LspAttach",
  opts = {
    wakeup_delay = 200, -- ms
    notifications = true,
  },
}
