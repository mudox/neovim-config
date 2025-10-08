return {
  "nvim-telescope/telescope-frecency.nvim",
  keys = {
    { "<leader>t<Space>", K.c("Telescope frecency workspace=CWD"), desc = "Frecency" },
  },
  config = function()
    require("telescope").load_extension("frecency")
  end,
}
