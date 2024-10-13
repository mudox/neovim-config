local function opts()
  return {
    filetypes = { "markdown", "quarto", "rmd", "Avante" },
  }
end

return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "quarto", "rmd", "Avante" },
  dependencies = {
    "nvim-treesitter",
    "nvim-web-devicons",
  },
}
