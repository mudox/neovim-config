function config() end

return {
  "monaqa/dial.nvim",
  -- stylua: ignore
  keys = {
    { "<C-a>", "<Plug>(dial-increment)",   mode = { "n", "v" }, remap = true, desc = "[Dial] Increment"        },
    { "<C-x>", "<Plug>(dial-decrement)",   mode = { "n", "v" }, remap = true, desc = "[Dial] Decrement"        },
    { "g<C-x>", "g<Plug>(dial-increment)", mode = { "n", "v" }, remap = true, desc = "[Dial] Global increment" },
    { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" }, remap = true, desc = "[Dial] Global decrement" },
  },
  config = config,
}
