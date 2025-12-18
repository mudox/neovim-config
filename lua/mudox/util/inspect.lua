local M = {}

local function fmt(tbl)
  local lines = vim.split(vim.inspect(tbl), "\n")
  if #lines == 1 then
    return lines[1]
  end

  for i = 2, #lines - 1 do
    lines[i] = "  │ " .. lines[i]
  end
  lines[#lines] = "  └ " .. lines[#lines]
  return table.concat(lines, "\n")
end

function M.win()
  local function opt(name)
    local text = fmt(vim.opt_local[name]:get())
    return ("  %-26s-> %s"):format(name, text)
  end

  local win = vim.fn.getwininfo(vim.fn.win_getid())[1]

  local lines = {
    ("win: %d %d tab(%d) %dx%d"):format(win.winnr, win.winid, win.tabnr, win.width, win.height),
    ("  qf: %d, loclist: %d, term: %d"):format(win.quickfix, win.loclist, win.terminal),
    "",
    opt("winhighlight"),
    "",
    ("buf: %d"):format(win.bufnr),
    ("  path: %s"):format(vim.fn.bufname()),
    opt("filetype"),
    "",
    opt("buftype"),
    opt("swapfile"),
    "",
    opt("buflisted"),
    opt("bufhidden"),
    "",
    opt("modifiable"),
    opt("readonly"),
  }

  print(table.concat(lines, "\n"))
end

return M
