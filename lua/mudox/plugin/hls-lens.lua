local cmd = [[<Cmd>lua require('hlslens').start()<Cr>]]
local keys = {
  { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<Cr>]] .. cmd },
  { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<Cr>]] .. cmd },
  { "*", "*" .. cmd },
  { "#", "#" .. cmd },
  { "g*", "g*" .. cmd },
  { "g#", "g#" .. cmd },
}

return {
  "kevinhwang91/nvim-hlslens",
  keys = keys,
  opts = {
    calm_down = true,
  },
  cond = false,
}
