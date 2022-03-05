-- vim: fdm=marker
vim.g.mapleader = ","

---@diagnostic disable: unused-local
local k = require("mudox.keymap")
local nmap = k.nmap
local nnop = k.nnop
local ncmd = k.ncmd
local imap = k.imap
local icmd = k.icmd
local vmap = k.vmap
---@diagnostic enable: unused-local

nmap("<C-7>", "<C-O>", { noremap = false })
nmap("<C-9>", "<C-I>", { noremap = false })

-- sensible `n, N`
nmap("n", '"Nn"[v:searchforward]', { expr = true })
nmap("N", '"Nn"[v:searchforward]', { expr = true })

-- sensible `Y`
nmap("Y", "y$")

-- `coX` to toggle syntax highlighting
nmap("coX", [[:execute 'setlocal syntax=' . ((&syntax == 'OFF') ? 'ON' : 'OFF')<Cr>]])

-- quick save file
ncmd("<C-s>", "write")
icmd("<C-s>", "write")

-- sensible `j, k`
nmap("j", "gj")
nmap("k", "gk")
nmap("gj", "")
nmap("gk", "")

-- `option-J,K,H,L` to jump among tabs
ncmd("<M-]>", "bnext")
ncmd("<M-[>", "bNext")
nmap("<M-l>", "gt")
nmap("<M-h>", "gT")

-- `q` triggers macro recording easily
nmap("<M-k>", "q")
nnop("q")
-- nmap('q:', 'q:')
-- nmap('q/', 'q/')

-- `Q` triggers Ex mode easily
nnop("Q")

-- sensible `zi`
nmap("zi", "zizz")

-- command history
-- `nvim_set_keymap` fails to handle `noremap` option
vim.cmd([[cmap <C-P> <Up>]])

-- search
nmap("n", "nzvzz", { remap = true })
nmap("N", "Nzvzz", { remap = true })

-- fold
nmap("zj", "zjzx", { remap = true })
nmap("zk", "zkzx", { remap = true })

-- quickly close window
ncmd("<C-w><C-w>", "wincmd q")

vim.cmd([[
function! WipeoutBuffer()
  try
    bwipeout
  catch /E444/
  catch /E89/
    lua vim.notify(
    \  'There are unsaved changes, can not wipeout buffer', 
    \  'warn',
    \  { title = 'WipeoutBuffer' }
    \)
  endtry
endfunction

nnoremap <silent> <C-w>r <Cmd>call WipeoutBuffer()<Cr>
]])

-- quickfix/location list window toggle
vim.cmd([[
function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

nnoremap <silent> <M-/>q <Cmd>call ToggleQuickFix()<Cr>

function! ToggleLocList()
  try
    if empty(filter(getwininfo(), 'v:val.loclist'))
      lopen
    else
      lclose
    endif
  catch /E776/
    lua vim.notify(
    \  'Empty location list', 
    \  'warn',
    \  { title = 'ToggleLocList' }
    \)
  endtry
endfunction

nnoremap <silent> <M-/>l <Cmd>call ToggleLocList()<Cr>
]])
