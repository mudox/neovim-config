local function edgy_main_wins()
  local ids = vim.tbl_values(require("edgy.editor").list_wins().main)
  table.sort(ids)
  return ids
end

local common = {}

function common:focus()
  vim.api.nvim_set_current_win(self:winid())
end

local left = setmetatable({}, {
  __index = common,
})

function left:winid()
  return edgy_main_wins()[1]
end

function left:open(file)
  left:focus()
  if file then
    vim.cmd.edit(file)
  end
end

local right = setmetatable({}, {
  __index = common,
})

function right:winid()
  return edgy_main_wins()[2]
end

function right:open(file)
  if not self:winid() then
    left:focus()
    file = file or "#"
    if not pcall(vim.cmd.vsplit, file) then
      vim.cmd.vsplit()
    end
  else
    self:focus()
    if file then
      vim.cmd.edit(file)
    end
  end
end

function right:close()
  vim.api.nvim_win_close(self:winid(), false)
end

local M = {
  left = left,
  right = right,
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

function M.right:open_alt()
  if vim.fn.bufname("#") ~= "" then
    self:open("#")
  else
    self:open()
  end
end

function M.right:open_or_alt()
  if vim.api.nvim_get_current_win() ~= self:winid() then
    self:open()
  else
    if vim.fn.bufname("#") ~= "" then
      vim.cmd.edit("#")
    else
      print("no # file")
    end
  end
end

return M
