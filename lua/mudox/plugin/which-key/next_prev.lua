---@type {string: string|table}
local next = { name = "next" }
---@type {string: string|table}
local prev = { name = "prev" }

local function add(key, t)
  next[key] = { X.dirop.wrap(t, "next"), t.name }
  prev[key] = { X.dirop.wrap(t, "prev"), t.name }
end

local c = X.dirop.wrap_cmd
local k = X.dirop.wrap_key

-- insert empty line
add("<Space>", {
  name = "Insert blankline",
  next = function()
    vim.cmd("put  =repeat(nr2char(10), v:count1)|silent '[-")
  end,
  prev = function()
    vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
  end,
})

-- swap line
add("e", {
  name = "Swap line",
  next = function()
    vim.cmd("silent! move +" .. vim.v.count1)
    vim.cmd.normal("==")
  end,
  prev = function()
    vim.cmd("silent! move --" .. vim.v.count1)
    vim.cmd.normal("==")
  end,
})

-- stylua: ignore start
add("a",     c("Argument file", "next",    "previous"))

add(",",     k("Change point",  "g,",      "g;",        true))
add("c",     k("Diff hunk",     "]c",      "[c",        true))

add("q",     c("Quickfix item", "cnext",   "cprevious"))
add("Q",     c("Quickfix file", "cnfile",  "cpfile"))
add("l",     c("Loclist item",  "lnext",   "lprevious"))
add("L",     c("Loclist file",  "lnfile",  "lpfile"))

add("<Tab>", c("Tabpage",       "tabnext", "tabprevious"))
-- stylua: ignore end

-- jumplist
-- <C-i> can not be used directly in `k` for unknown reason
K.nmap("<Plug>MdxJumplistForwards", "<C-i>")
K.nmap("<Plug>MdxJumplistBackwards", "<C-o>")
add("j", k("Jumplist", "<Plug>MdxJumplistForwards", "<Plug>MdxJumplistBackwards", false))

return {
  next = next,
  prev = prev,
}
