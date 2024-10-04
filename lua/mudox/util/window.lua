local M = {}

local function all_valid_floating_wins()
  local wins = vim.tbl_filter(function(w)
    local ok, config = pcall(vim.api.nvim_win_get_config, w)
    if not ok then
      return false
    else
      return config.relative ~= ""
    end
  end, vim.api.nvim_list_wins())

  wins = vim.tbl_map(function(w)
    local config = vim.api.nvim_win_get_config(w)
    config.id = w
    return config
  end, wins)

  return wins
end

function M.close_all_floating_wins()
  for _, win in ipairs(all_valid_floating_wins()) do
    pcall(vim.api.nvim_win_close, win.id, false)
  end
end

function M.focus_next_floating_win()
  local wins = vim.tbl_filter(function(w)
    return w.focusable
  end, all_valid_floating_wins())
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

function M.is_floating(win)
  return vim.api.nvim_win_get_config(win).relative ~= ""
end

return M
