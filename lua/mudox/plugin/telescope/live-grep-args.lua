return {
  "nvim-telescope/telescope-live-grep-args.nvim",
  dependencies = "telescope.nvim",
  keys = { { "<leader>tG", "<Cmd>Telescope live_grep_args<Cr>", desc = "RG raw" } },
  config = function()
    require("telescope").load_extension("live_grep_args")
  end,
}
