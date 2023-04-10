local M = {}

---get terminal object of current window
function M.get_current_term()
  local tx = require("toggleterm.terminal")
  return tx.get(tx.get_focused_id())
end

---move current terminal to specified position
function M.move(direction)
  local term = M.get_current_term()
  if not term then
    return
  end

  term:close()
  term:open(nil, direction)
end

return M
