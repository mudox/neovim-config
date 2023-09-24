local M = {}

---get terminal object of current window
function M.get_current_term()
  local t = require("toggleterm.terminal")
  return t.get(t.get_focused_id())
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

--- toggle terminal window between horizontal and float
function M.change_layout()
  local term = M.get_current_term()
  if not term then
    return
  end

  if term.direction == "float" then
    M.move("horizontal")
  else
    M.move("float")
  end
end

return M
