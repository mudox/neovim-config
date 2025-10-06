return {
  "crispgm/telescope-heading.nvim",
  dependencies = "telescope.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>tO", "<Cmd>Telescope heading<Cr>", desc = "Headings" },
    { "go",         "<Cmd>Telescope heading<Cr>", desc = "[Telescope] Headings" },
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
