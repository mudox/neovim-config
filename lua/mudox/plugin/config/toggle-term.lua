require("toggleterm").setup {
  open_mapping = "<M-j>",

  shade_terminals = false,

  direction = "float",

  float_opts = {
    highlights = {
      border = 'FloatBorder',
      winblend = 0,
    },
  },
}

-- Mappings to quickly go out of terminal window without closing it
function _G._mdx_set_terminal_keymaps()
  local function map(from, to)
    local tmap = require("mudox.keymap").tmap
    tmap(from, to, { bufnr = 0 })
  end

  map("<C-h>", [[<C-\><C-n><C-W>h]])
  map("<C-j>", [[<C-\><C-n><C-W>j]])
  map("<C-k>", [[<C-\><C-n><C-W>k]])
  map("<C-l>", [[<C-\><C-n><C-W>l]])
end

vim.cmd('autocmd! TermOpen term://* lua _mdx_set_terminal_keymaps()')
