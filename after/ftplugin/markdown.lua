local o = vim.opt_local

o.spell = false

o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true

o.list = false

local function insert_time()
  local lines = {
    "",
    "### " .. os.date("%H:%M") .. "  ",
    "",
    "",
  }
  vim.api.nvim_put(lines, "c", true, true)
  vim.cmd.startinsert()
end

K.imap(K.i("t"), insert_time, { desc = "insert current time", buffer = true })
