-- NOTE: plugin keymaps are defined in plugin spec files

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Keymap helpers 〈
---@diagnostic disable: unused-local
local k = require("mudox.lib.keymap")

local nmap = k.nmap
local nnop = k.nnop
local ncmd = k.ncmd

local imap = k.imap
local icmd = k.icmd

local vmap = k.vmap

local cmap = k.cmap

local omap = k.omap
---@diagnostic enable: unused-local
-- 〉

-- Common mappings 〈

-- sensible `n, N`
k.expr({ "n", "x", "o" }, "n", '"Nn"[v:searchforward] . "zvzz"', { expr = true })
k.expr({ "n", "x", "o" }, "N", '"nN"[v:searchforward] . "zvzz"', { expr = true })

-- save file
k.cmd({ "n", "i", "x" }, "<C-s>", "update")

-- sensible `j, k`
nmap("j", "gj")
nmap("k", "gk")
nnop("gj")
nnop("gk")

-- buffers
-- HACK: kitty.conf remap `ctrl+shift+[|]` to `ctrl+shift+f|g`
ncmd("<M-[>71", "bnext")
ncmd("<M-[>70", "bNext")

-- tabs
nmap("<M-l>", "gt")
nmap("<M-h>", "gT")

-- `q` triggers macro recording too easily
nmap("<C-g>q", "q")
nnop("q")

-- `Q` triggers Ex mode too easily
nnop("Q")

-- sensible `zi`
nmap("zi", "zizz")

-- command history
cmap("<C-p>", "<Up>")

-- open fold
nmap("zj", "zjzx", { remap = true })
nmap("zk", "zkzx", { remap = true })
nmap("g;", "g;zv", { remap = true })
nmap("g,", "g,zv", { remap = true })

-- quickly wipeout buffer
ncmd("<C-w>r", "call mudox#lib#wipeoutBuffer()")

-- close current tabpage
ncmd("<C-w><C-t>", "tabclose")

-- copy entire buffer content into system pasteboard
ncmd("yf", "0,$y +")

-- resize window using <ctrl> arrow keys
ncmd("<C-Up>", "resize +2", { desc = "Increase window height" })
ncmd("<C-Down>", "resize -2", { desc = "Decrease window height" })
ncmd("<C-Left>", "vertical resize -2", { desc = "Decrease window width" })
ncmd("<C-Right>", "vertical resize +2", { desc = "Increase window width" })

-- move Lines
nmap("<A-j>", "<Cmd>m .+1<Cr>==", { desc = "Move line down" })
nmap("<A-k>", "<Cmd>m .-2<Cr>==", { desc = "Move line up" })
imap("<A-j>", "<Esc><Cmd>m .+1<Cr>==gi", { desc = "Move line down" })
imap("<A-k>", "<Esc><Cmd>m .-2<Cr>==gi", { desc = "Move line up" })
vmap("<A-j>", ":m '>+1<Cr>gv=gv", { desc = "Move selection down" })
vmap("<A-k>", ":m '<-2<Cr>gv=gv", { desc = "Move selection up" })

-- clear search highlight with <Esc>
nmap("<Esc>", "<Cmd>noh<Cr><Esc>", { desc = "Escape and clear hlsearch" })
imap("<Esc>", "<Cmd>noh<Cr><Esc>", { desc = "Escape and clear hlsearch" })

-- 〉

-- Insert mode mappings 〈

imap("<M-.>", "<Esc>A")
imap("<M-l>", "<C-x><C-l>", { noremap = false, desc = "Omni completion line" })

-- 〉

-- b for (
omap("ir", "i[")
omap("ar", "a[")
omap("ia", "i<")
omap("aa", "a<")
