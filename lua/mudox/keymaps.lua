-- vim: fml& fdn& fdm=marker fmr=〈,〉

vim.g.mapleader = K.leader.primary
vim.g.maplocalleader = K.leader.secondary

-- Save file
K.map({ "n", "i", "v", "o" }, "<C-s>", "<Cmd>write<Cr><Esc>", { desc = "Save file" })

-- Sensible `j, k`
K.nmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
K.nmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Tabpage navigation
for i = 1, 9 do
  K.nmap("]" .. i, i .. "gt", { desc = "Goto tabpage " .. i })
end

-- Folding
K.nmap("zi", "zizz", "Toggle fold")
-- stylua: ignore
local zjk = {
  name = "Fold",
  left = function() vim.cmd.normal { "zjzv", bang = true } end,
  right = function() vim.cmd.normal { "zkzv", bang = true } end,
}
K.nmap("zj", X.dirop.left(zjk), "Goto next fold start")
K.nmap("zk", X.dirop.right(zjk), "Goto prev fold end")

K.nmap("z<Space>", "zMzA", { remap = true })


-- stylua: ignore
local fdlvl = {
  name = "Fold Level",
  left = function() vim.cmd.normal { "zr", bang = true } end,
  right = function() vim.cmd.normal { "zm", bang = true } end,
}
K.nmap("<C-S-.>", X.dirop.left(fdlvl), "Unfold a level")
K.nmap("<C-S-,>", X.dirop.right(fdlvl), "Fold a level")
-- K.nmap("<C-S-,>", "zm", { remap = true })
-- K.nmap("<C-S-.>", "zr", { remap = true })

-- Clear search highlight with <Esc>
K.map({ "n", "i" }, "<Esc>", "<Cmd>nohlsearch<Cr><Esc>", { desc = "Clear hlsearch & escape" })

-- Useless legacy `sleep` function
K.nnop("gs")

-- `<C-w>`
K.ncmd(K.sc("w"), 'call feedkeys("\\<C-w>", "t")', { desc = "<C-w>+" })

-- Change list
K.nmap("g;", "g;zv", { remap = true })
K.nmap("g,", "g,zv", { remap = true })

-- Insert mode keymaps
K.imap("<M-.>", "<Esc>A", { desc = "Jump to line end" })
K.imap("<M-l>", "<C-x><C-l>", { remap = true, desc = "Omni completion line" })

-- Copy entire buffer content into system pasteboard
K.ncmd("yf", "0,$y +")

-- Macro
K.nnop("q")
K.nmap(K.sc("q"), "q", { desc = "macro" })

-- Digraph
K.imap("<C-k><C-k>", "<C-k>", { desc = "Enter digraph" })

-- Window jump
K.cmd({ "n", "t" }, "<C-h>", "wincmd h")
K.cmd({ "n", "t" }, "<C-j>", "wincmd j")
K.cmd({ "n", "t" }, "<C-k>", "wincmd k")
K.cmd({ "n", "t" }, "<C-l>", "wincmd l")
K.cmd({ "n", "t" }, "<M-Bslash>", "wincmd p")

-- Profiling
K.nmap(K.p("ps"), function()
  vim.cmd([[
    :profile start /tmp/nvim-profile.log
    :profile func *
    :profile file *
    ]])
end, { desc = "Start profiling" })

K.nmap(K.p("pe"), function()
  vim.cmd([[
    :profile stop
    :edit /tmp/nvim-profile.log
    ]])
end, { desc = "End profiling" })

-- Clipboard
K.map({ "i", "c" }, "<C-k>v", "<C-r><C-o>+", { desc = "Paste from clipboard" })
K.map({ "n", "v" }, "<C-S-Y>", '"+y', { desc = "Yank to clipboard" })

-- Cmdline
K.nmap(K.sc(";"), ":", { silent = false, desc = "[cmdline] :" })
K.nmap(K.sc("l"), ":lua ", { silent = false, desc = "[cmdline] :lua" })

-- Terminal
K.tmap("<Esc>", "<C-Bslash><C-N>", { desc = "[term] Leave" })
