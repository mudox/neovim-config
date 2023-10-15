return {
  "mg979/vim-visual-multi",
  event = { "BufEnter" },
  init = function()
    -- vim.api.nvim_set_var("VM_leader", "\\")
  end,
  config = function()
    vim.cmd([[silent! VMTheme neon]])
  end,
}
