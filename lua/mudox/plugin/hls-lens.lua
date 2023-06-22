local keys = {
  { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<Cr><Cmd>lua require('hlslens').start()<Cr>]] },
  { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<Cr><Cmd>lua require('hlslens').start()<Cr>]] },
  { "*", [[*<Cmd>lua require('hlslens').start()<Cr>]] },
  { "#", [[#<Cmd>lua require('hlslens').start()<Cr>]] },
  { "g*", [[g*<Cmd>lua require('hlslens').start()<Cr>]] },
  { "g#", [[g#<Cmd>lua require('hlslens').start()<Cr>]] },
}

return {
  "kevinhwang91/nvim-hlslens",
  keys = keys,
  opts = {
    calm_down = true,
  },
}
