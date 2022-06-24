-- vim: fdm=marker fmr=〈,〉

vim.g.mapleader = ","

-- Keymap helpers 〈
---@diagnostic disable: unused-local
local k = require("mudox.keymap")

local nmap = k.nmap
local nnop = k.nnop
local ncmd = k.ncmd

local imap = k.imap
local icmd = k.icmd

local vmap = k.vmap

local cmap = k.cmap
---@diagnostic enable: unused-local
-- 〉

-- Common mappings 〈

-- sensible `n, N`
nmap("n", '"Nn"[v:searchforward] . "zvzz"', { expr = true })
nmap("N", '"nN"[v:searchforward] . "zvzz"', { expr = true })

-- quick save file
ncmd("<C-s>", "update")
icmd("<C-s>", "update")

-- sensible `j, k`
nmap("j", "gj")
nmap("k", "gk")
nnop("gj")
nnop("gk")

-- buffers
-- HACK: kitty.conf remap `ctrl+shift+[|]` to `ctrl+shift+f|g`
ncmd("<C-S-g>", "bnext")
ncmd("<C-S-f>", "bNext")

-- tabs
nmap("<M-l>", "gt")
nmap("<M-h>", "gT")

-- `q` triggers macro recording too easily
nmap("\\q", "q")
nnop("q")

-- `Q` triggers Ex mode too easily
nnop("Q")

-- sensible `zi`
nmap("zi", "zizz")

-- command history
-- `nvim_set_keymap` fails to handle `noremap` option
cmap("<C-p>", "<Up>", { remap = true })

-- open fold
nmap("zj", "zjzx", { remap = true })
nmap("zk", "zkzx", { remap = true })
nmap("g;", "g;zv", { remap = true })
nmap("g,", "g,zv", { remap = true })

-- quickly close window
ncmd("<C-w><C-w>", "wincmd q")

-- quickly wipeout buffer
ncmd("<C-w>r", "call mudox#lib#wipeoutBuffer()")

-- quickfix/location list window toggle
ncmd("yoL", "call mudox#lib#toggleLocList()")
ncmd("yoq", "call mudox#lib#toggleQuickFix()")

-- 〉

-- Insert mode mappings 〈

imap("<M-;>", "<Esc>A")

-- 〉

require("mudox.mode.which-key")
