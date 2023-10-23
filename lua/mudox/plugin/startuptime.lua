return {
  "dstein64/vim-startuptime",
  keys = { { "<leader>pS", "<Cmd>StartupTime<Cr>", desc = "Startup time" } },
  cmd = "StartupTime",
  config = function()
    vim.g.startuptime_tries = 10
  end,
}
