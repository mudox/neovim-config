-- vim: fml& fdn& fdm=marker fmr=〈,〉

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Common mappings 〈

-- save file
K.map({ "n", "i", "x", "o" }, "<C-s>", "<Cmd>write<Cr><Esc>", { desc = "Save file" })

-- sensible `j, k`
K.map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
K.map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

for i = 1, 9 do
  K.nmap("]" .. i, i .. "gt", { desc = "Goto tabpage " .. i })
end

-- `q` triggers macro recording too easily
-- nnop("q")
-- nmap("Q:", "q:", { remap = true })
-- nmap("Q/", "q/", { remap = true })
-- nmap("Q?", "q?", { remap = true })

-- `Q` triggers Ex mode too easily
-- nnop("Q")

-- sensible `zi`
K.nmap("zi", "zizz")

-- command history
K.cmap("<C-p>", "<Up>")

-- folding
K.nmap("zj", "zjzx", { remap = true })
K.nmap("zk", "zkzx", { remap = true })
K.nmap("g;", "g;zv", { remap = true })
K.nmap("g,", "g,zv", { remap = true })
K.nmap("z<Space>", "zMzA", { remap = true })
-- K.nmap("z<Space>", "zCzA", { remap = true })

-- close current tabpage
K.ncmd("<C-w><C-t>", "tabclose")

-- resize window using <ctrl> arrow keys
local s = 4
K.ncmd("<C-Up>", "resize +" .. s, { desc = "Increase window height" })
K.ncmd("<C-Down>", "resize -" .. s, { desc = "Decrease window height" })
K.ncmd("<C-Left>", "vertical resize -" .. s, { desc = "Decrease window width" })
K.ncmd("<C-Right>", "vertical resize +" .. s, { desc = "Increase window width" })

-- clear search highlight with <Esc>
K.map({ "n", "i" }, "<Esc>", "<Cmd>nohlsearch<Cr><Esc>", { desc = "Clear hlsearch & escape" })

-- smart close
-- https://www.reddit.com/r/neovim/comments/16aan6k/my_latest_favorite_mapping_share_yours/
K.nmap("<C-q>", function()
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

K.nnop("gs") -- sleep

K.nmap("'", "`")

-- 〉

-- Insert 〈

K.imap("<M-.>", "<Esc>A")
K.imap("<M-l>", "<C-x><C-l>", { noremap = false, desc = "Omni completion line" })

-- Insert 〉

-- Operator 〈

K.omap("ir", "i[")
K.omap("ar", "a[")
K.omap("ia", "i<")
K.omap("aa", "a<")

-- Operator 〉

-- Terminal 〈

K.tmap("<C-h>", "<Cmd>wincmd h<Cr>")
K.tmap("<C-j>", "<Cmd>wincmd j<Cr>")
K.tmap("<C-k>", "<Cmd>wincmd k<Cr>")
K.tmap("<C-l>", "<Cmd>wincmd l<Cr>")

-- Terminal 〉

-- Buffer 〈

-- copy entire buffer content into system pasteboard
K.ncmd("yf", "0,$y +")

-- Buffer 〉

-- Profiling 〈

K.nmap("<leader>ps", function()
  vim.cmd([[
    :profile start /tmp/nvim-profile.log
    :profile func *
    :profile file *
    ]])
end, { desc = "Start profiling" })

K.nmap("<leader>pe", function()
  vim.cmd([[
    :profile stop
    :edit /tmp/nvim-profile.log
    ]])
end, { desc = "End profiling" })

-- Profiling 〉
