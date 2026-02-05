vim.g.mapleader = K.leader.primary
vim.g.maplocalleader = K.leader.secondary

-- Save file
K.map({ "n", "i" }, "<C-s>", "<Cmd>write<Cr><Esc>", { desc = "save file" })

-- Sensible `j, k`
K.nmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
K.nmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Tabpage navigation
for i = 1, 9 do
  K.nmap("]" .. i, i .. "gt")
end

-- Folding
K.nmap("zi", "zizz", "Toggle fold")
-- stylua: ignore
local zjk = {
  name = "Fold Nav",
  left = function() vim.cmd.normal { "zkzv", bang = true } end,
  right = function() vim.cmd.normal { "zjzv", bang = true } end,
}
K.nmap("zk", X.arrows.left(zjk), "Goto prev fold end")
K.nmap("zj", X.arrows.right(zjk), "Goto next fold start")
K.normal("z<Space>", "zMzvzczO", { remap = true })

-- K.nmap("/", "/\\v", { desc = "/ very magically" })
-- Clear search highlight with <Esc>
K.map({ "n", "i" }, "<Esc>", "<Cmd>nohlsearch<Cr><Esc>", { desc = "clear hlsearch & escape" })

-- `<C-w>`
K.ncmd(K.sc("w"), 'call feedkeys("\\<C-w>", "t")', { desc = "-> <C-w>" })

-- Insert mode keymaps
K.imap("<M-.>", "<Esc>A", { desc = "jump to line end" })
K.imap("<M-l>", "<C-x><C-l>", { remap = true, desc = "omni completion line" })

-- Macro
-- `.nnop("q")
K.nmap(K.sc("q"), "q", { desc = "macro" })

-- Window jump
local function tmux_nav(direction, tmux_cmd)
  return function()
    local curwin = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. direction)
    if curwin == vim.api.nvim_get_current_win() then
      vim.fn.system("tmux select-pane " .. tmux_cmd)
    end
  end
end

-- stylua: ignore start
K.map({ "n", "t" }, "<C-h>", tmux_nav("h", "-L"), { desc = "to left window / tmux pane" })
K.map({ "n", "t" }, "<C-l>", tmux_nav("l", "-R"), { desc = "to right window / tmux pane" })
K.map({ "n", "t" }, "<C-j>", tmux_nav("j", "-D"), { desc = "to down window / tmux pane" })
K.map({ "n", "t" }, "<C-k>", tmux_nav("k", "-U"), { desc = "to up window / tmux pane" })
-- stylua: ignore end

-- K.cmd({ "n", "t" }, "<M-Bslash>", "wincmd p")

-- Window resizing
local resize = X.arrows.excmd("Window resize", "wincmd >", "wincmd <", "wincmd -", "wincmd +")
-- stylua: ignore start
K.nmap("<C-w>>", X.arrows.left(resize),  { desc = "width +"  })
K.nmap("<C-w><", X.arrows.right(resize), { desc = "width -"  })
K.nmap("<C-w>+", X.arrows.up(resize),    { desc = "height +" })
K.nmap("<C-w>-", X.arrows.down(resize),  { desc = "height -" })
-- stylua: ignore end

-- Yank & paste
K.map({ "i", "c" }, K.i("v"), "<C-r><C-o>+", { desc = "paste from clipboard" })
K.map({ "n", "v" }, "<C-S-Y>", '"+y', { desc = "yank to clipboard" })
K.xmap("<C-u>", function()
  local k = ("y`[%d[Pgv"):format(vim.v.count1)
  vim.cmd.normal { k, bang = false }
end, { desc = "duplicate above" })
K.xmap("<C-d>", function()
  local k = ("y`]%d]pgv"):format(vim.v.count1)
  vim.cmd.normal { k, bang = false }
end, { desc = "duplicate below" })

-- Cmdline
local function cmdstart()
  -- stylua: ignore
  local cmds = {
    [1]  = ":lua ",
    [11] = ":=",
    [2]  = ":set ",
    [22] = ":setlocal ",
    [3]  = ":%s/\\v",
    [4]  = ":Git ",
    [5]  = ":checkhealth ",
  }
  local cmd = cmds[vim.v.count] or ":"
  vim.api.nvim_feedkeys(cmd, "n", false)
end
K.nmap("<Enter>", cmdstart, { desc = "enter cmdline" })

-- Terminal
K.tmap("<Esc>", "<C-Bslash><C-N>", { desc = "[term] leave" })

-- Open in finder
K.nmap("gX", K.c("!open %:p:h"), { desc = "open dir in finder" })

-- stylua: ignore
K.nmap(K.sc"v", function() X.layout.right:open("#") end, { desc = "edit #" })

K.nnop("]]")
K.nnop("[[")

K.nmap(K.p("wq"), function()
  local open = true
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      open = false
    end
  end

  if open then
    return vim.cmd.copen()
  end
end, "[toggle] quickfix")
