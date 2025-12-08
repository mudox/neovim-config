-- stylua: ignore start
local keys = {
  { "<M-]>", "<Cmd>ISwapNodeWithRight<Cr>", desc = "[iswap] swap node forwards" },
  { "<M-[>", "<Cmd>ISwapNodeWithLeft<Cr>",  desc = "[iswap] swap node backwards" },
  { "\\x",   "<Cmd>ISwapWith<Cr>",          desc = "[iswap] swap current item with ..." },
  { "\\X",   "<Cmd>ISwap<Cr>",              desc = "[iswap] swap 2 items" },
  { "\\n",   "<Cmd>ISwapNodeWith<Cr>",      desc = "[iswap] swap current node" },
  { "\\N",   "<Cmd>ISwapNode<Cr>",          desc = "[iswap] swap 2 nodes" },
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
  cond = false,
}
