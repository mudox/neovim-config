local M = {
  { "]", group = "next" },
  { "][", group = "start of" },
  { "]]", group = "end of" },

  { "[", group = "prev" },
  { "[[", group = "start of" },
  { "[]", group = "end of" },
}

local function add(key, t)
  table.insert(M, {
    { "]" .. key, X.arrows.left(t), desc = t.name },
    { "[" .. key, X.arrows.right(t), desc = t.name },
  })
end

local excmd = X.arrows.excmd
local normal = X.arrows.normal

-- insert empty line
add("<Space>", {
  name = "insert blankline",
  left = function()
    vim.cmd("put  =repeat(nr2char(10), v:count1)|silent '[-")
  end,
  right = function()
    vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
  end,
})

-- swap line
add("e", {
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
add("a", excmd("argument file", "next", "previous"))

-- change list
local op = normal("change point", "g;zv", "g,zv")
op.notify = function(dir)
  if dir == 'left' or dir == 'up' then
    print('older change point')
  else
    print('newer change point')
  end
end
K.nmap("g;", X.arrows.left(op), { desc = "older change point" })
K.nmap("g,", X.arrows.right(op), { desc = "newer change point" })

-- diff
add("c", normal("diff hunk", "]c", "[c", true))

-- quickfix / loclist
add("q", excmd("quickfix item", "cnext", "cprevious"))
add("Q", excmd("quickfix file", "cnfile", "cpfile"))
add("l", excmd("loclist item", "lnext", "lprevious"))
add("L", excmd("loclist file", "lnfile", "lpfile"))

add("<Tab>", excmd("Tabpage", "tabnext", "tabprevious"))
-- stylua: ignore end

-- jumplist
-- <C-i> can not be used directly in `k` for unknown reason
K.nmap("<Plug>MdxJumplistForwards", "<C-i>")
K.nmap("<Plug>MdxJumplistBackwards", "<C-o>")
add("j", normal("jumplist", "<Plug>MdxJumplistForwards", "<Plug>MdxJumplistBackwards", false))

return M
