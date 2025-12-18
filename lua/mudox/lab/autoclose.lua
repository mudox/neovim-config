local M = {
  busy = false,
  last_was_float = false,
}

local function is_floating_win(win)
  local cfg = vim.api.nvim_win_get_config(win)
  return cfg.relative ~= ""
end

local function should_close(win)
  local ok, v = pcall(vim.api.nvim_win_get_var, win, "autoclose")
  return ok and v == true
end

local function close_wins()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if is_floating_win(win) and should_close(win) then
      pcall(vim.api.nvim_win_close, win, true)
    end
  end
end

local function on_win_enter()
  if M.busy then
    return
  end

  local win = vim.api.nvim_get_current_win()
  local is_float = is_floating_win(win)

  -- only trigger when: floating -> normal
  if not is_float and M.last_was_float then
    M.busy = true
    close_wins()
    M.busy = false
  end

  M.last_was_float = is_float
end

function M.init()
  vim.api.nvim_create_autocmd("WinEnter", {
    desc = "Auto close floating windows when focus returns to normal window",
    callback = on_win_enter,
  })
end

return M
