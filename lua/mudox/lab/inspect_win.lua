local function fill(buf)
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

  local l = Line()
  local n = 1

  l:append("buftype:   ")
  l:append(buftype)
  l:render(buf, -1, n)
  n = n + 1

  l = Line()
  l:append("buflisted: ")
  l:append(buflisted)
  l:render(buf, -1, n)
  n = n + 1

  l = Line()
  l:append("swapfile:  ")
  l:append(swapfile)
  l:render(buf, -1, n)
end

local function show()
  local w, h = 50, 3
  local win = require("nui.popup") {
    position = {
      row = vim.fn.winheight(0) - h - 1,
      col = vim.fn.winwidth(0) - w - 1,
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

  win:mount()

  -- vim.api.nvim_buf_set_lines(w.bufnr, 0, -1, false, text())
  fill(win.bufnr)
  vim.bo[win.bufnr].modifiable = false

  win:map("n", "q", function()
    win:unmount()
  end)

  U.on({ "CursorMoved", "WinLeave" }, function()
    win:unmount()
  end, { once = true })
end

return show
