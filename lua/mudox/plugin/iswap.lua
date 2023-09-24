-- stylua: ignore start
local keys = {
  { "<M-]>", "<Cmd>ISwapNodeWithRight<Cr>", desc = "[ISwap] Swap node forwards" },
  { "<M-[>", "<Cmd>ISwapNodeWithLeft<Cr>",  desc = "[ISwap] Swap node backwards" },
  { "\\x",   "<Cmd>ISwapWith<Cr>",          desc = "[ISwap] Swap current item with ..." },
  { "\\X",   "<Cmd>ISwap<Cr>",              desc = "[ISwap] Swap 2 items" },
  { "\\n",   "<Cmd>ISwapNodeWith<Cr>",      desc = "[ISwap] Swap current node" },
  { "\\N",   "<Cmd>ISwapNode<Cr>",          desc = "[ISwap] Swap 2 nodes" },
}
-- stylua: ignore end

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
