local M = {}

function M.list_floats()
  return vim.iter(vim.api.nvim_list_wins()):fold({}, function(acc, wid)
    local ok, config = pcall(vim.api.nvim_win_get_config, wid)
    if not ok or config.relative == "" then
      return acc
    else
      config.id = wid
      acc[#acc + 1] = config
      return acc
    end
  end)
end

function M.close_all_floats()
  for _, win in ipairs(M.list_floats()) do
    pcall(vim.api.nvim_win_close, win.id, false)
  end
end

function M.focus_next_float()
  local wins = vim.tbl_filter(function(w)
    return w.focusable
  end, M.list_floats())
  if #wins == 0 then
    print("No feasible floating windows found")
    return
  end

  local cur_win = vim.api.nvim_get_current_win()

  for i, w in ipairs(wins) do
    if cur_win == w then
      if i == #wins then
        vim.api.nvim_set_current_win(wins[1])
      else
        vim.api.nvim_set_current_win(wins[i + 1])
      end
    end
  end

  -- current window is split window
  -- vim.print(wins)
  vim.api.nvim_set_current_win(wins[1].id)
end

---Return if the window is a floating window
---@param win number?
---@return boolean
function M.is_float(win)
  win = win or vim.api.nvim_get_current_win()
  return vim.api.nvim_win_get_config(win).relative ~= ""
end

return M
