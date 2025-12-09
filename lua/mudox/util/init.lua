local M = setmetatable({}, {
  __index = function(t, key)
    t[key] = require("mudox.util." .. key)
    return t[key]
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

-- all my b: vars go under b:mdx table
M.b = setmetatable({}, {
  __index = function(_, key)
    local mdx = vim.b.mdx or { desc = "my b:var vault" }
    vim.b.mdx = mdx
    return vim.b.mdx[key]
  end,
  __newindex = function(_, key, value)
    local mdx = vim.b.mdx or { desc = "my b:var vault" }
    mdx[key] = value
    vim.b.mdx = mdx
  end,
})

-- all my w: vars go under w:mdx table
M.w = setmetatable({}, {
  __index = function(_, key)
    local mdx = vim.w.mdx or { desc = "my w:var vault" }
    vim.w.mdx = mdx
    return vim.w.mdx[key]
  end,
  __newindex = function(_, key, value)
    local mdx = vim.w.mdx or { desc = "my w:var vault" }
    mdx[key] = value
    vim.w.mdx = mdx
  end,
})

return M
