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
ncmd("L", "bnext")
ncmd("H", "bNext")
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

ncmd("<C-w>r", "call mudox#lib#wipeoutBuffer()")

-- quickfix/location list window toggle
ncmd("<M-/>l", "call mudox#lib#toggleLocList()")
ncmd("<M-/>q", "call mudox#lib#toggleQuickFix()")
vim.cmd([[PackerLoad which-key.nvim]])
local wk = require("which-key")
