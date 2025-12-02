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
  K.nmap("]" .. i, i .. "gt", { desc = "tab #" .. i })
end

-- Folding
K.nmap("zi", "zizz", "Toggle fold")
-- stylua: ignore
local zjk = {
  name = "Fold Nav",
  left = function() vim.cmd.normal { "zjzv", bang = true } end,
  right = function() vim.cmd.normal { "zkzv", bang = true } end,
}
K.nmap("zj", X.arrows.left(zjk), "Goto next fold start")
K.nmap("zk", X.arrows.right(zjk), "Goto prev fold end")

K.nmap("z<Space>", "zMzA", { remap = true })

local fdlvl = (function()
  function notify(dir)
    local lvl = vim.wo.foldlevel + ((dir == "right" or dir == "up") and -1 or 1)
    print(("fold level %d %s"):format(lvl, (dir == "right" or dir == "up") and "↗" or "↘"))
  end

  return {
    name = "Fold Level",
    left = function()
      notify("left")
      vim.cmd.normal { "zr", bang = true }
    end,
    right = function()
      notify("right")
      vim.cmd.normal { "zm", bang = true }
    end,
    notify = function(dir)
      notify(dir)
    end,
  }
end)()
K.nmap("<C-S-.>", X.arrows.left(fdlvl), "Unfold a level")
K.nmap("<C-S-,>", X.arrows.right(fdlvl), "Fold a level")

K.nmap("/", "/\\v", { desc = "Search magically" })
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
-- K.cmd({ "n", "t" }, "<M-Bslash>", "wincmd p")

-- Window resizing
local resize_op = X.arrows.excmd("Window resize", "wincmd >", "wincmd <", "wincmd -", "wincmd +")
K.nmap("<C-w>>", X.arrows.left(resize_op), { desc = "Increase window width" })
K.nmap("<C-w><", X.arrows.right(resize_op), { desc = "Decrease window width" })
K.nmap("<C-w>+", X.arrows.up(resize_op), { desc = "Increase window height" })
K.nmap("<C-w>-", X.arrows.down(resize_op), { desc = "Decrease window height" })

-- Clipboard
K.map({ "i", "c" }, "<C-k>v", "<C-r><C-o>+", { desc = "Paste from clipboard" })
K.map({ "n", "v" }, "<C-S-Y>", '"+y', { desc = "Yank to clipboard" })
K.xmap("<C-d>", function()
  print(vim.v.count1)
  local k = ("y`]%d]pgv"):format(vim.v.count1)
  print(k)
  vim.cmd.normal { k, bang = true }
end, { desc = "Duplicate below" })

-- Cmdline
K.nmap(K.sc(";"), ":", { silent = false, desc = "[cmdline] :" })
K.nmap(K.sc("l"), ":lua ", { silent = false, desc = "[cmdline] :lua" })

-- Terminal
K.tmap("<Esc>", "<C-Bslash><C-N>", { desc = "[term] Leave" })

-- Open in finder
K.nmap("gX", K.c("!open %:p:h"), { desc = "Open dir in finder" })

-- stylua: ignore
K.nmap(K.sc"v", function() X.layout.secondary:open("#") end, { desc = "Edit #" })
