-- vim: fml& fdn& fdm=marker fmr=〈,〉

vim.g.mapleader = ","
vim.g.maplocalleader = ","

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
K.nmap("zi", "zizz")
-- stylua: ignore
local zjk = {
  name = "Fold",
  next = function() vim.cmd.normal { "zjzx", bang = true } end,
  prev = function() vim.cmd.normal { "zkzx", bang = true } end,
}
K.nmap("zj", X.dirop.wrap(zjk, "next"))
K.nmap("zk", X.dirop.wrap(zjk, "prev"))
K.nmap("z<Space>", "zMzA", { remap = true })
K.nmap("zn", function()
  vim.opt_local.foldenable = false
  U.redraw_status_column()
end)

-- Resize window using <Ctrl>+arrow keys
local s = 4
K.ncmd("<C-Up>", "resize +" .. s, { desc = "Increase window height" })
K.ncmd("<C-Down>", "resize -" .. s, { desc = "Decrease window height" })
K.ncmd("<C-Left>", "vertical resize -" .. s, { desc = "Decrease window width" })
K.ncmd("<C-Right>", "vertical resize +" .. s, { desc = "Increase window width" })

-- Clear search highlight with <Esc>
K.map({ "n", "i" }, "<Esc>", "<Cmd>nohlsearch<Cr><Esc>", { desc = "Clear hlsearch & escape" })

-- Smart close
-- https://www.reddit.com/r/neovim/comments/16aan6k/my_latest_favorite_mapping_share_yours/
-- K.nmap("<C-q>", function()
--   -- close current window if there are more than 1 window
--   -- else close current tab if there are more than 1 tab
--   -- else close current vim
--   if #vim.api.nvim_tabpage_list_wins(0) > 1 then
--     vim.cmd.close()
--   elseif #vim.api.nvim_list_tabpages() > 1 then
--     vim.cmd.tabclose()
--   else
--     vim.cmd("confirm qall")
--   end
-- end, { desc = "Smart close" })

-- Useless legacy `sleep` function
K.nnop("gs")

-- Change list
K.nmap("g;", "g;zv", { remap = true })
K.nmap("g,", "g,zv", { remap = true })
K.nmap("<C-S-j>", "g;", { remap = true })
K.nmap("<C-S-k>", "g,", { remap = true })

-- Insert mode keymaps
K.imap("<M-.>", "<Esc>A")
K.imap("<M-l>", "<C-x><C-l>", { noremap = false, desc = "Omni completion line" })

-- Copy entire buffer content into system pasteboard
K.ncmd("yf", "0,$y +")
-- K.nmap("p", [["_p]])

-- Macro
K.nnop("q")
K.nmap(";q", "q", { desc = "macro" })

-- Terminal 〈

K.tmap("<C-h>", "<Cmd>wincmd h<Cr>")
K.tmap("<C-j>", "<Cmd>wincmd j<Cr>")
K.tmap("<C-k>", "<Cmd>wincmd k<Cr>")
K.tmap("<C-l>", "<Cmd>wincmd l<Cr>")

-- Terminal 〉

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
