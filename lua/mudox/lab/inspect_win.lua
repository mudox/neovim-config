local function pad(text, width)
  local r = text

  if #text < width then
    local n = width - #text
    r = text .. string.rep(" ", n)
  end

  return r
end

local function lines()
  local Text = require("nui.text")
  local Line = require("nui.line")

  local function bool(b)
    if b then
      return Text("true", "DiagnosticOk")
    else
      return Text("false", "DiagnosticError")
    end
  end

  local buftype = vim.bo.buftype == "" and Text("normal", "Comment") or Text(vim.bo.buftype, "String")
  local buflisted = bool(vim.bo.buflisted)
  local swapfile = bool(vim.bo.swapfile)
  local modifiable = bool(vim.bo.modifiable)

  local r = {}
  local l = Line()
  local w = 16

  l:append(pad("buftype:", w))
  l:append(buftype)
  table.insert(r, l)

  l = Line()
  l:append(pad("buflisted:", w))
  l:append(buflisted)
  table.insert(r, l)

  l = Line()
  l:append(pad("swapfile:", w))
  l:append(swapfile)
  table.insert(r, l)

  l = Line()
  l:append(pad("modifiable:", w))
  l:append(modifiable)
  table.insert(r, l)

  return r
end

local function show()
  local lines = lines()

  local w, h = 25, #lines
  local win = require("nui.popup") {
    anchor = "SE",
    position = {
      row = vim.fn.winheight(0),
      col = vim.fn.winwidth(0),
    },
    size = { width = w, height = h },
    relative = "win",
    enter = false,
    focusable = false,
    border = {
      style = "single",
      text = { top = " Inspect ", top_align = "right" },
      padding = { left = 1 },
    },
    buf_options = { buflisted = false, buftype = "nofile", swapfile = false },
    win_options = { winblend = 10, winhighlight = "Normal:Normal,FloatBorder:Normal,FloatTitle:Normal" },
  }

  for n, l in ipairs(lines) do
    l:render(win.bufnr, -1, n)
  end
  vim.bo[win.bufnr].modifiable = false

  win:mount()

  win:map("n", "q", function()
    win:unmount()
  end)

  U.on({ "CursorMoved", "WinLeave" }, function()
    win:unmount()
  end, { once = true })
end

return show
