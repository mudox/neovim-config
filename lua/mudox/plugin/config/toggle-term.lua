require("toggleterm").setup {
  open_mapping = "<M-j>",

  shade_terminals = false,

  direction = "float",

  start_in_insert = true,

  float_opts = {
    highlights = {
      border = "FloatBorder",
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

vim.cmd("autocmd! TermOpen term://* lua _mdx_set_terminal_keymaps()")

-- Custom terminals

local Terminal = require("toggleterm.terminal").Terminal
local primary = Terminal:new {
  cmd = "zsh",
  hiiden = true,
  direction = "float",
  ---@diagnostic disable-next-line: unused-local
  on_open = function(term)
    vim.cmd("startinsert!")
  end,
}

function _G._mdx_toggle_primary()
  primary:toggle()
end

function _G._mdx_open_primary_bottom()
  local function open()
    primary.direction = "horizontal"
    primary:open()
  end
  if primary:is_open() then
    if not primary:is_split() then
      primary:close()
      open()
    else
      return
    end
  else -- closed
    open()
  end
end

function _G._mdx_open_primary_float()
  local function open()
    primary.direction = "float"
    primary:open()
  end
  if primary:is_open() then
    if not primary:is_float() then
      primary:close()
      open()
    else
      return
    end
  else -- closed
    open()
  end
end

local nlua = require("mudox.keymap").nlua
nlua("<M-j>", "_mdx_toggle_primary()")

local function map(from, to)
  local cmd = ([[
    autocmd TermEnter term://*toggleterm#* tnoremap <silent> %s <Cmd>%s<Cr>

    nnoremap <silent> %s <Cmd>%s<Cr>
    inoremap <silent> %s <Cmd>%s<Cr>
  ]]):format(from, to, from, to, from, to)

  vim.cmd(cmd)
end

map("<C-t><Space>", "lua _mdx_open_primary_bottom()")
map("<C-t><C-t>", "lua _mdx_open_primary_float()")
