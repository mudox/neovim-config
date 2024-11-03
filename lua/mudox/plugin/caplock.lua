return {
  "tpope/vim-capslock",
  -- stylua: ignore
  keys = {
    { "<C-k><Space>", "<Plug>CapsLockToggle", remap = true, mode = { "i", "c" }, desc = "[CapLock] Toggle" },
    { "gC",           "<Plug>CapsLockToggle", remap = true, mode = "n",          desc = "[CapLock] Toggle" },
  },
}
