local function config() end

return {
  "monaqa/dial.nvim",
  -- stylua: ignore
  keys = {
    { "<C-a>", "<Plug>(dial-increment)",   mode = { "n", "v" }, remap = true, desc = "[dial] increment"        },
    { "<C-x>", "<Plug>(dial-decrement)",   mode = { "n", "v" }, remap = true, desc = "[dial] decrement"        },
    { "g<C-x>", "g<Plug>(dial-increment)", mode = { "n", "v" }, remap = true, desc = "[dial] global increment" },
    { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" }, remap = true, desc = "[dial] global decrement" },
  },
  config = config,
}
