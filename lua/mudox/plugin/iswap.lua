local keys = {
  { "<M-]>", "<Cmd>ISwapNodeWithRight<Cr>", desc = "Swap Node Forwards" },
  { "<M-[>", "<Cmd>ISwapNodeWithLeft<Cr>", desc = "Swap Node Backwards" },
  { "\\x", "<Cmd>ISwapWith<Cr>", desc = "Swap Current Item With ..." },
  { "\\X", "<Cmd>ISwap<Cr>", desc = "Swap 2 Items" },
  { "\\n", "<Cmd>ISwapNodeWith<Cr>", desc = "Swap Current Node" },
  { "\\N", "<Cmd>ISwapNode<Cr>", desc = "Swap 2 Nodes" },
}

local opts = {
  flash_style = false,
  move_cursor = true,
  autoswap = true,
}

return {
  "mizlan/iswap.nvim",
  keys = keys,
  opts = opts,
}
