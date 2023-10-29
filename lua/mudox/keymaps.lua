-- vim: fml& fdn& fdm=marker fmr=〈,〉

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Keymap helpers 〈

---@diagnostic disable: unused-local
local k = require("mudox.util.keymap")

local map = k.map
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

-- save file
map({ "n", "i", "x", "o" }, "<C-s>", "<Cmd>write<Cr><Esc>", { desc = "Save file" })

-- sensible `j, k`
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- tabs
nmap("<M-l>", "gt")
nmap("<M-h>", "gT")

for i = 1, 9 do
  nmap("]" .. i, i .. "gt", { desc = "Goto tabpage " .. i })
end

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
local s = 4
ncmd("<C-Up>", "resize +" .. s, { desc = "Increase window height" })
ncmd("<C-Down>", "resize -" .. s, { desc = "Decrease window height" })
ncmd("<C-Left>", "vertical resize -" .. s, { desc = "Decrease window width" })
ncmd("<C-Right>", "vertical resize +" .. s, { desc = "Increase window width" })

-- clear search highlight with <Esc>
map({ "n", "i" }, "<Esc>", "<Cmd>nohlsearch<Cr><Esc>", { desc = "Clear hlsearch & escape" })

-- smart close
-- https://www.reddit.com/r/neovim/comments/16aan6k/my_latest_favorite_mapping_share_yours/
nmap("<C-q>", function()
  -- close current window if there are more than 1 window
  -- else close current tab if there are more than 1 tab
  -- else close current vim
  if #vim.api.nvim_tabpage_list_wins(0) > 1 then
    vim.cmd.close()
  elseif #vim.api.nvim_list_tabpages() > 1 then
    vim.cmd.tabclose()
  else
    vim.cmd("confirm qall")
  end
end, { desc = "Smart close" })

-- 〉

-- Insert 〈

imap("<M-.>", "<Esc>A")
imap("<M-l>", "<C-x><C-l>", { noremap = false, desc = "Omni completion line" })

-- Insert 〉

-- Operator 〈

omap("ir", "i[")
omap("ar", "a[")
omap("ia", "i<")
omap("aa", "a<")

-- Operator 〉

-- Terminal 〈

tmap("<C-h>", "<Cmd>wincmd h<Cr>")
tmap("<C-j>", "<Cmd>wincmd j<Cr>")
tmap("<C-k>", "<Cmd>wincmd k<Cr>")
tmap("<C-l>", "<Cmd>wincmd l<Cr>")

-- Terminal 〉

-- Buffer 〈

-- copy entire buffer content into system pasteboard
ncmd("yf", "0,$y +")

-- Buffer 〉

-- Profiling 〈

nmap("<leader>ps", function()
  vim.cmd([[
    :profile start /tmp/nvim-profile.log
    :profile func *
    :profile file *
    ]])
end, { desc = "Start profiling" })

nmap("<leader>pe", function()
  vim.cmd([[
    :profile stop
    :edit /tmp/nvim-profile.log
    ]])
end, { desc = "End profiling" })

-- Profiling 〉
