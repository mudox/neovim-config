local cmd = [[<Cmd>lua require('hlslens').start()<Cr>]]
local keys = {
  { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<Cr>zv]] .. cmd },
  { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<Cr>zv]] .. cmd },
  { "*", "*" .. cmd },
  { "#", "#" .. cmd },
  { "g*", "g*" .. cmd },
  { "g#", "g#" .. cmd },
}

return {
  "kevinhwang91/nvim-hlslens",
  keys = keys,
  opts = {},
}
