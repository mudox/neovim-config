local M = {
  { "]", group = "next" },
  { "[", group = "prev" },
}

local function a(key, t)
  table.insert(M, {
    { "]" .. key, X.dirop.left(t), desc = t.name },
    { "[" .. key, X.dirop.right(t), desc = t.name },
  })
end

local c = X.dirop.excmd
local k = X.dirop.normal

-- insert empty line
a("<Space>", {
  name = "Insert blankline",
  left = function()
    vim.cmd("put  =repeat(nr2char(10), v:count1)|silent '[-")
  end,
  right = function()
    vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
  end,
})

-- swap line
a("e", {
  name = "Swap line",
  left = function()
    vim.cmd("silent! move +" .. vim.v.count1)
    vim.cmd.normal("==")
  end,
  right = function()
    vim.cmd("silent! move --" .. vim.v.count1)
    vim.cmd.normal("==")
  end,
})

-- stylua: ignore start
a("a", c("Argument file", "next", "previous"))

-- change list
a(",", k("Change point", "g,zv", "g;zv", true))

-- diff
a("c", k("Diff hunk", "]c", "[c", true))

-- quickfix / loclist
a("q", c("Quickfix item", "cnext", "cprevious"))
a("Q", c("Quickfix file", "cnfile", "cpfile"))
a("l", c("Loclist item", "lnext", "lprevious"))
a("L", c("Loclist file", "lnfile", "lpfile"))

a("<Tab>", c("Tabpage", "tabnext", "tabprevious"))
-- stylua: ignore end

-- jumplist
-- <C-i> can not be used directly in `k` for unknown reason
K.nmap("<Plug>MdxJumplistForwards", "<C-i>")
K.nmap("<Plug>MdxJumplistBackwards", "<C-o>")
a("j", k("Jumplist", "<Plug>MdxJumplistForwards", "<Plug>MdxJumplistBackwards", false))

return M
