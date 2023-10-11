local buf = vim.api.nvim_create_buf(true, true)
local win = vim.api.nvim_open_win(buf, false, {
  relative = "cursor",
  row = 0,
  col = 1,
  width = 50,
  height = 22,
  border = "rounded",
  title = "Test window API",
  footer = "10 lines in total",
})
