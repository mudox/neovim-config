-- stylua: ignore
local M = {
  { "]",  group = "next"     },
  { "][", group = "start of" },
  { "]]", group = "end of"   },

  { "[",  group = "prev"     },
  { "[[", group = "start of" },
  { "[]", group = "end of"   },
}

local function add(key, op)
  table.insert(M, {
    { "[" .. key, X.arrows.left(op), desc = op.name },

    { "]" .. key, X.arrows.right(op), desc = op.name },
  })
end

local excmd = X.arrows.excmd
local normal = X.arrows.normal

-- insert empty line
-- stylua: ignore
add("<Space>", {
  name = "blankline",
  left = function()  vim.cmd("put! =repeat(nr2char(10), v:count1) | silent '[+") end,
  right = function() vim.cmd("put  =repeat(nr2char(10), v:count1) | silent ']-") end,
})

-- swap line
add("e", {
  name = "swap line",
  left = function()
    vim.cmd("silent! move -" .. (vim.v.count1 + 1))
    vim.cmd.normal("==")
  end,
  right = function()
    vim.cmd("silent! move +" .. vim.v.count1)
    vim.cmd.normal("==")
  end,
})

-- stylua: ignore start
-- args
add("a", excmd("argfile", "previous", "next"))

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
add("q", excmd("quickfix item", "cprevious", "cnext"))
add("Q", excmd("quickfix file", "cpfile", "cnfile"))
add("l", excmd("loclist item", "lprevious", "lnext"))
add("L", excmd("loclist file", "lpfile", "lnfile"))

-- tabpage
add("<Tab>", excmd("tab", "tabprevious", "tabnext"))
-- stylua: ignore end

-- jumplist
local function jump(back)
  return function()
    local key = vim.api.nvim_replace_termcodes(back and "<C-o>" or "<C-i>", true, false, true)
    vim.api.nvim_feedkeys(key, "n", false)
  end
end
add("j", {
  name = "jumplist",
  left = jump(true),
  right = jump(false),
})

return M
