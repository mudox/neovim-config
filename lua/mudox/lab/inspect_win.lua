local Text = require("nui.text")
local Line = require("nui.line")

local function pad(text, width)
  local r = text

  if #text < width then
    local n = width - #text
    r = text .. string.rep(" ", n)
  end

  return r
end
local function dim(s)
  return Text(s, "Comment")
end
local function on(s)
  return Text(s, "DiagnosticOk")
end
local function off(s)
  return Text(s, "DiagnosticError")
end
local function bool(s, b)
  return b and on(s) or off(s)
end
local function flag(name, ref)
  local s = vim.bo[name] and name or "no" .. name

  if vim.bo[name] == ref then
    return bool(s, ref)
  else
    return dim(s)
  end
end
local function enum(s)
  return Text(s, "LspKindEnum")
end
local sep = Text("  ")

local function lines()
  local function bool(b)
    if b then
      return Text("true", "DiagnosticOk")
    else
      return Text("false", "DiagnosticError")
    end
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local winid = vim.api.nvim_get_current_win()
  local winnr = vim.fn.winnr()

  local r = {}
  local l

  table.insert(
    r,
    Line {
      Text("buf: "),
      Text(tostring(bufnr), "Number"),
      sep,
      Text(U.window.is_floating(winid) and "popup: " or "split: "),
      Text(("%d (%d)"):format(winid, winnr), "Number"),
    }
  )

  table.insert(
    r,
    Line {
      vim.bo.buftype ~= "" and Text(vim.bo.buftype, "Type") or dim("file"),
      sep,
      flag("buflisted", false),
      sep,
      flag("swapfile", false),
      sep,
      flag("modifiable", false),
      sep,
      flag("readonly", true),
    }
  )

  return r
end

local function show()
  local lines = lines()

  local w, h = 65, #lines
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
      text = { top = "   Inspect ", top_align = "right" },
      padding = { left = 1 },
    },
    zindex = 100,
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

  On({ "CursorMoved", "WinLeave" }, function()
    win:unmount()
  end, { once = true })
end

return show
