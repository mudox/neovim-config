local function symbols()
  require("telescope.builtin").symbols { sources = { "nerd", "julia", "math" } }
end

return {
  "nvim-telescope/telescope-symbols.nvim",
  dependencies = "telescope.nvim",
  keys = {
    { K.p"ti", symbols, desc = "Symbols" },
    { "<C-k>i", symbols, desc = "Symbols", mode = "i" },
  },
}
