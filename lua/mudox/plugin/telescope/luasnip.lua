return {
  "benfowler/telescope-luasnip.nvim",
  dependencies = "telescope.nvim",
  keys = {
    { K.p("ts"), K.c("Telescope luasnip theme=dropdown"), desc = "snippets" },
  },
  config = function()
    require("telescope").load_extension("luasnip")
  end,
}
