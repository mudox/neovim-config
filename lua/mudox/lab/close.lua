local M = {}

function M.window()
  -- if the closing window is the last main window, do nothing
  local m = require("edgy.editor").list_wins().main
  local w = vim.api.nvim_get_current_win()
  if vim.tbl_count(m) == 1 and m[w] then
    return
  end
  vim.cmd("close")
end

function M.buffer() end

return M
