return {
  "tpope/vim-capslock",
  -- stylua: ignore
  keys = {
    { K.ip"<Space>", "<Plug>CapsLockToggle", remap = true, mode = { "i", "c" }, desc = "[caplock] toggle" },
  },
}
