return {
  "catgoose/telescope-helpgrep.nvim",
  dependencies = "telescope.nvim",
  keys = { { "<leader>th", "<Cmd>Telescope helpgrep<Cr>", desc = "Grep help" } },
  config = function()
    require("telescope").load_extension("helpgrep")
  end,
}
