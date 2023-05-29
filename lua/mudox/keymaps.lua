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

local tmap = k.tmap

local omap = k.omap
---@diagnostic enable: unused-local
-- 〉

-- Common mappings 〈

-- sensible `n, N`
k.expr({ "n", "x", "o" }, "N", [[":set hlsearch<Cr>" . "nN"[v:searchforward] . "zv"]], { expr = true })
k.expr({ "n", "x", "o" }, "n", [[":set hlsearch<Cr>" . "Nn"[v:searchforward] . "zv"]], { expr = true })

-- save file
k.cmd({ "n", "i" }, "<C-s>", "update")

-- sensible `j, k`
nmap("j", "gj")
nmap("k", "gk")
nnop("gj")
nnop("gk")

-- tabs
nmap("<M-l>", "gt")
nmap("<M-h>", "gT")

-- `q` triggers macro recording too easily
nnop("q")
-- nmap("<C-g>", "q", { remap = true })
nmap("Q:", "q:", { remap = true })
nmap("Q/", "q/", { remap = true })
nmap("Q?", "q?", { remap = true })

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

-- close current tabpage
ncmd("<C-w><C-t>", "tabclose")

-- resize window using <ctrl> arrow keys
ncmd("<C-Up>", "resize +2", { desc = "Increase window height" })
ncmd("<C-Down>", "resize -2", { desc = "Decrease window height" })
ncmd("<C-Left>", "vertical resize -2", { desc = "Decrease window width" })
ncmd("<C-Right>", "vertical resize +2", { desc = "Increase window width" })

-- move Lines
nmap("<M-j>", "<Cmd>m .+1<Cr>==", { desc = "Move Current Line Down" })
nmap("<M-k>", "<Cmd>m .-2<Cr>==", { desc = "Move Current Line Up" })
imap("<M-j>", "<Esc><Cmd>m .+1<Cr>==gi", { desc = "Move Current Line Down" })
imap("<M-k>", "<Esc><Cmd>m .-2<Cr>==gi", { desc = "Move Current Line Up" })
vmap("<M-j>", ":m '>+1<Cr>gv=gv", { desc = "Move selection down" })
vmap("<M-k>", ":m '<-2<Cr>gv=gv", { desc = "Move selection up" })

-- clear search highlight with <Esc>
nmap("<Esc>", "<Cmd>noh<Cr><Esc>", { desc = "Escape and clear hlsearch" })
imap("<Esc>", "<Cmd>noh<Cr><Esc>", { desc = "Escape and clear hlsearch" })

-- 〉

-- Insert mode mappings 〈

imap("<M-.>", "<Esc>A")
imap("<M-l>", "<C-x><C-l>", { noremap = false, desc = "Omni completion line" })

-- 〉

omap("ir", "i[")
omap("ar", "a[")
omap("ia", "i<")
omap("aa", "a<")

-- terminal
tmap("<Esc>", "<C-\\><C-n>")

tmap("<C-h>", "<Cmd>wincmd h<Cr>")
tmap("<C-j>", "<Cmd>wincmd j<Cr>")
tmap("<C-k>", "<Cmd>wincmd k<Cr>")
tmap("<C-l>", "<Cmd>wincmd l<Cr>")

-- inspect
ncmd("<leader>vi", "Inspect")
ncmd("<leader>vt", "InspectTree")

-- Buffer 〈

-- buffer navigation
-- <C-S-n> to open telescope to select buffers
ncmd("»", "bnext") -- <C-S-]> remapped
ncmd("«", "bNext") -- <C-S-[> remapped

-- quickly wipeout buffer
ncmd("<C-w>r", "call mudox#lib#wipeoutBuffer()")

-- copy entire buffer content into system pasteboard
ncmd("yf", "0,$y +")

-- Buffer 〉
