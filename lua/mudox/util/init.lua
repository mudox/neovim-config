local M = setmetatable({}, {
  __index = function(u, key)
    u[key] = require("mudox.util." .. key)
    return u[key]
  end,
})

function M.in_kitty()
  return vim.env.KITTY_WINDOW_ID ~= nil
end

function M.in_alacritty()
  return vim.env.ALACRITTY_WINDOW_ID ~= nil
end

function M.logo()
  local function version()
    local first_line = vim.fn.execute("version"):match("([^\n]+)")
    return "  " .. first_line:gsub("^NVIM%s*", "")
  end

  -- ASCII generator: https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=mudox
  -- Use font `ANSI Shadow`

  local filename = ".nvim-logo.ascii.txt"
  local ok, lines = pcall(vim.fn.readfile, filename)
  lines = ok and lines or vim.fn.readfile(vim.env.MDX_NVIM_DIR .. "/asset/logo.ascii.txt")

  -- version line
  local ver = version()
  table.insert(lines, "")
  table.insert(lines, "")
  table.insert(lines, ver)

  return table.concat(lines, "\n")
end

return M
