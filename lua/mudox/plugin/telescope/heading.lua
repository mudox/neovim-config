return {
  "crispgm/telescope-heading.nvim",
  dependencies = "telescope.nvim",
  -- stylua: ignore
  keys = {
    { K.p"tH", K.c"Telescope heading", desc = "Headings"             },
    { "goh",   K.c"Telescope heading", desc = "[Telescope] Headings" },
  },
  config = function()
    local t = require("telescope")
    t.setup {
      heading = {
        treesitter = true,
      },
    }
    t.load_extension("heading")
  end,
}
