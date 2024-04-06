local next = {}
local prev = {}

local function register(key, t)
  next[key] = { X.dirop.wrap(t, "next"), t.name }
  prev[key] = { X.dirop.wrap(t, "prev"), t.name }
end

local function cmd_dirop(name, n, p)
  -- stylua: ignore
  return {
    name = name,
    next = function() vim.cmd("silent! " .. n) end,
    prev = function() vim.cmd("silent! " .. p) end,
  }
end

local function key_dirop(name, n, p, bang)
  -- stylua: ignore
  return {
    name = name,
    next = function()
      pcall(vim.cmd.normal, { vim.keycode(n), bang = bang })
      -- vim.cmd.normal { vim.keycode(n), bang = bang }
    end,
    prev = function()
      pcall(vim.cmd.normal, { vim.keycode(p), bang = bang })
      -- vim.cmd.normal { vim.keycode(p), bang = bang }
    end,
  }
end

register("<Space>", {
  name = "insert blankline",
  next = function()
    vim.cmd("put  =repeat(nr2char(10), v:count1)|silent '[-")
  end,
  prev = function()
    vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
  end,
})

register("x", {
  name = "swap line",
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
register("a",     cmd_dirop("argument file", "next",    "previous"))

register(",",     key_dirop("change point",  "g,",      "g;",        true))
-- register("j",     key_dirop("jump point",    "<C-i>",   "<C-o>",     true))

register("q",     cmd_dirop("quickfix item", "cnext",   "cprevious"))
register("Q",     cmd_dirop("quickfix file", "cnfile",  "cpfile"))
register("l",     cmd_dirop("loclist",       "lnext",   "lprevious"))
register("L",     cmd_dirop("loclist file",  "lnfile",  "lpfile"))

register("<Tab>", cmd_dirop("tabpage",       "tabnext", "tabprevious"))
-- stylua: ignore end

return {
  next = next,
  prev = prev,
}
