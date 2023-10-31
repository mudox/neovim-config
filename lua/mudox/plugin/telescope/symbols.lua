local function symbols()
  require("telescope.builtin").symbols { sources = { "nerd", "julia", "math" } }
end

return {
  "nvim-telescope/telescope-symbols.nvim",
  dependencies = "telescope.nvim",
  keys = { { "<leader>ti", symbols, desc = "Symbols" } },
}
