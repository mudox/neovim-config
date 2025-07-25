-- vim: fml& fdn& fdm=marker fmr=〈,〉

vim.g.mapleader = K.leader
vim.g.maplocalleader = K.leader

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
  next = function() vim.cmd.normal { "zjzv", bang = true } end,
  prev = function() vim.cmd.normal { "zkzv", bang = true } end,
}
K.nmap("zj", X.dirop.wrap(zjk, "next"), "Goto next fold start")
K.nmap("zk", X.dirop.wrap(zjk, "prev"), "Goto prev fold end")
K.nmap("z<Space>", "zMzA", { remap = true })

-- K.nmap("zn", function()
--   vim.opt_local.foldenable = false
--   U.redraw_status_column()
-- end)

-- Resize window using <Ctrl>+arrow keys
-- local s = 4
-- K.ncmd("<C-Up>", "resize +" .. s, { desc = "Increase window height" })
-- K.ncmd("<C-Down>", "resize -" .. s, { desc = "Decrease window height" })
-- K.ncmd("<C-Left>", "vertical resize -" .. s, { desc = "Decrease window width" })
-- K.ncmd("<C-Right>", "vertical resize +" .. s, { desc = "Increase window width" })

-- Clear search highlight with <Esc>
K.map({ "n", "i" }, "<Esc>", "<Cmd>nohlsearch<Cr><Esc>", { desc = "Clear hlsearch & escape" })

-- Useless legacy `sleep` function
K.nnop("gs")

-- `;w` = `<C-w>`
K.ncmd(";w", 'call feedkeys("\\<C-w>", "t")', { desc = "<C-w>" })

-- Change list
K.nmap("g;", "g;zv", { remap = true })
K.nmap("g,", "g,zv", { remap = true })
K.nmap("<C-S-j>", "g;", { remap = true })
K.nmap("<C-S-k>", "g,", { remap = true })

-- Insert mode keymaps
K.imap("<M-.>", "<Esc>A", { desc = "Jump to line end" })
K.imap("<M-l>", "<C-x><C-l>", { remap = true, desc = "Omni completion line" })

-- Copy entire buffer content into system pasteboard
K.ncmd("yf", "0,$y +")

-- Macro
K.nnop("q")
K.nmap(";q", "q", { desc = "macro" })

-- Digraph
K.imap("<C-k><C-k>", "<C-k>", { desc = "Enter digraph" })

-- Terminal
K.tmap("<C-h>", "<Cmd>wincmd h<Cr>")
K.tmap("<C-j>", "<Cmd>wincmd j<Cr>")
K.tmap("<C-k>", "<Cmd>wincmd k<Cr>")
K.tmap("<C-l>", "<Cmd>wincmd l<Cr>")

-- Profiling
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

-- Clipboard
K.map({ "i", "c" }, "<C-k>v", "<C-r><C-o>+", { desc = "Paste from clipboard" })
K.map({ "n", "v" }, "<C-S-Y>", '"+y', { desc = "Yank to clipboard" })
