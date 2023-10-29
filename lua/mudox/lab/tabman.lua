-- special tabpage for specific usecases, e.g. debug, git, gitdiff

-- create or goto tabpage, recreating or not?
-- delete tabpage after some idle time
-- keymaps to goto given tagpage like <M-y> for tmux

local varname = "mdx_tabman_tabpage_id"

---@param cmd string|function: command to create the tabpage
---@param id string: tabman page id
local function _create(cmd, id)
  if type(cmd) == "string" then
    vim.cmd(cmd)
  else
    cmd()
  end
  vim.api.nvim_tabpage_set_var(0, varname, id)
  local new_h = vim.api.nvim_get_current_tabpage()
  local new_nr = vim.fn.tabpagenr()
  assert(type(new_nr) == "number")
  return new_h, new_nr
end

---@param id string: tabman page id
---@param new_nr number: tabpage number of which to exclude
local function _clear_old(id, new_nr)
  for _, info in ipairs(vim.fn.gettabinfo()) do
    if info.tabnr ~= new_nr then
      if info.variables.mdx_tabman_tabpage_id == id then
        vim.cmd.tabclose(info.tabnr)
      end
    end
  end
end

---@param id string: tabman page id
---@return number?: tabpage number if found
local function find(id)
  for _, info in ipairs(vim.fn.gettabinfo()) do
    if info.variables.mdx_tabman_tabpage_id == id then
      return info.tabnr
    end
  end
end

---@param cmd string|function: command to create the tabpage
---@param id string: tabman page id
local function recreate(cmd, id)
  local new_h, new_nr = _create(cmd, id)
  _clear_old(id, new_nr)
  return new_h, new_nr
end

---@param cmd string|function: command to create the tabpage
---@param id string: tabman page id
local function open(cmd, id)
  local nr = find(id)
  if nr then
    vim.cmd.tabnext(nr)
  else
    _create(cmd, id)
  end
end

return {
  find = find,
  open = open,
  recreate = recreate,
}
