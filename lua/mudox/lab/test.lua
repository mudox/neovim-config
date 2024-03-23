local api = vim.api
-- local fn = vim.fn

local lines = {}

local function section_conform()
  table.insert(lines, "Conform")

  local cf = require("conform")
  local formatters = cf.list_formatters(0)

  local s = vim.split(vim.inspect(formatters), "\n")
  vim.list_extend(lines, s)
end

-- buffer
local buf = api.nvim_create_buf(true, false)
section_conform()
api.nvim_buf_set_lines(buf, 0, -1, false, lines)

-- window
local float_scale = 0.7
_ = api.nvim_open_win(buf, true, {
  relative = "editor",
  height = math.floor(vim.o.lines * float_scale + 0.5),
  width = math.floor(vim.o.columns * float_scale + 0.5),
  row = math.floor(vim.o.lines * (1 - float_scale) / 2 + 0.5),
  col = math.floor(vim.o.columns * (1 - float_scale) / 2 + 0.5),
  zindex = 1000,
  style = "minimal",
  border = "none",
})
