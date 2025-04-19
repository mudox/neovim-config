local function edgy_main_wins()
  local ids = vim.tbl_values(require("edgy.editor").list_wins().main)
  table.sort(ids)
  return ids
end

local common = {}

function common:focus()
  vim.api.nvim_set_current_win(self:winid())
end

local main = setmetatable({}, {
  __index = common,
})

function main:winid()
  return edgy_main_wins()[1]
end

function main:open(file)
  main:focus()
  if file then
    vim.cmd.edit(file)
  end
end

local secondary = setmetatable({}, {
  __index = common,
})

function secondary:winid()
  return edgy_main_wins()[2]
end

function secondary:open(file)
  if not self:winid() then
    main:focus()
    vim.cmd.vsplit(file)
  else
    self:focus()
    if file ~= nil then
      vim.cmd.edit(file)
    end
  end
end

function secondary:close()
  vim.api.nvim_win_close(self:winid(), false)
end

local M = {
  main = main,
  secondary = secondary,
}

function M:one_window()
  local wins = edgy_main_wins()
  for i = 2, #wins do
    vim.api.nvim_win_close(wins[i], false)
  end
end

function M:two_windows()
  local wins = edgy_main_wins()
  for i = 3, #wins do
    vim.api.nvim_win_close(wins[i], false)
  end
end

return M
