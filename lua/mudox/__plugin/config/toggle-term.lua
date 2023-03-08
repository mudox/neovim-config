-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Setup 〈

require("toggleterm").setup {
  open_mapping = "<M-j>",

  shade_terminals = false,

  direction = "float",

  start_in_insert = true,

  highlights = {
    border = "FloatBorder",
    winblend = 0,
  },

  float_opts = {
    -- border = "curved",
  },
}

-- 〉

-- Key mappings 〈

-- Mappings to quickly go out of terminal window without closing it
function _G._mdx_set_terminal_keymaps()
  local function map(from, to)
    local tmap = require("mudox.keymap").tmap
    tmap(from, to, { buffer = 0 })
  end

  -- map("<C-h>", [[<C-\><C-n><C-W>h]])
  -- map("<C-l>", [[<C-\><C-n><C-W>l]])
  -- map("<C-j>", [[<C-\><C-n><C-W>j]])
  map("<C-k>", [[<C-\><C-n><C-W>k]])
end

vim.cmd("autocmd! TermOpen term://* lua _mdx_set_terminal_keymaps()")

--〉

-- Custom terminals 〈

local Terminal = require("toggleterm.terminal").Terminal

-- Primary terminal 〈

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

local nmap = require("mudox.keymap").nmap
nmap("<M-j>", _G._mdx_toggle_primary)

local function map(from, to)
  local cmd = ([[
    autocmd TermEnter term://*toggleterm#* tnoremap <silent> %s <Cmd>%s<Cr>

    nnoremap <silent> %s <Cmd>%s<Cr>
    inoremap <silent> %s <Cmd>%s<Cr>
  ]]):format(from, to, from, to, from, to)

  vim.cmd(cmd)
end

map("<M-k><Space>", "lua _mdx_open_primary_bottom()")
map("<M-k><M-k>", "lua _mdx_open_primary_float()")

-- Primary terminal 〉

-- Custom terminals 〉
