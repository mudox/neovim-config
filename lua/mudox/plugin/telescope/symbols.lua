local function symbols()
  require("telescope.builtin").symbols { sources = { "nerd", "julia", "math" } }
end

return {
  "nvim-telescope/telescope-symbols.nvim",
  dependencies = "telescope.nvim",
  -- stylua: ignore
  keys = {
    { K.p"ti", symbols, desc = "Symbols" },
    { K.ip"i", symbols, desc = "Symbols", mode = "i" },
  },
}
