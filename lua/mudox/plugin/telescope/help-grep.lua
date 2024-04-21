return {
  "catgoose/telescope-helpgrep.nvim",
  dependencies = "telescope.nvim",
  config = function()
    require("telescope").load_extension("helpgrep")
  end,
}
