return {
  "mg979/vim-visual-multi",
  keys = { "<C-n>", mode = { "n", "i", "v" } },
  config = function()
    vim.cmd [[silent! VMTheme neon]]
  end,
}
