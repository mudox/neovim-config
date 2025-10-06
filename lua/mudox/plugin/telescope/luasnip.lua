return {
  "benfowler/telescope-luasnip.nvim",
  dependencies = "telescope.nvim",
  keys = {
    { "<leader>ts", "<Cmd>Telescope luasnip theme=dropdown<Cr>", desc = "Snippets" },
  },
  config = function()
    require("telescope").load_extension("heading")
  end,
}
