return {
  "nvim-telescope/telescope-live-grep-args.nvim",
  dependencies = "telescope.nvim",
  keys = { { K.p("tG"), K.c("Telescope live_grep_args"), desc = "RG raw" } },
  config = function()
    require("telescope").load_extension("live_grep_args")
  end,
}
