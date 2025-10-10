return {
  "nvim-telescope/telescope-frecency.nvim",
  keys = {
    { K.p"t<Space>", K.c("Telescope frecency workspace=CWD"), desc = "Frecency" },
  },
  config = function()
    require("telescope").load_extension("frecency")
  end,
}
