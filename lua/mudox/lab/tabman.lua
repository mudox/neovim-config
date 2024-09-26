-- Exclusive tabpages for specific usecases, e.g. git, git diff, debugging, testing ...
--
-- Features:
-- [x] create or goto tabpage if already exits
-- [x] force re-creating tabpage
-- [ ] delete tabpage after some idle time
-- [ ] keymaps to goto given tagpage like <M-y> for tmux

local varname = "mdx_tabman"

---create tabpage
---@param id string: unique tabpage id as well as readable label
---@param cmd string|function: ex-command or lua function to create the new tabpage
---@return number tabpage id
---@return number tabpage number
local function _create(id, cmd)
  if type(cmd) == "string" then
    vim.cmd(cmd)
  else
    cmd()
  end

  vim.cmd.BufferLineTabRename(id)
  vim.api.nvim_tabpage_set_var(0, varname, { id = id, cmd = cmd })

  -- tabman created tabpage can not be main tabpage
  if vim.fn.tabpagenr() == 1 then
    vim.notify("tabman created tabpage occupied main tabpage's position", vim.log.levels.WARN, { title = "TabMan" })
  end

  return vim.api.nvim_get_current_tabpage(), vim.fn.tabpagenr()
end

---close old tabpage that has the same id as new tabpage
---@param id string: tabman page id
---@param new_nr number: tabpage number of which to exclude
local function _clear_old(id, new_nr)
  for _, t in ipairs(vim.fn.gettabinfo()) do
    if t.tabnr ~= new_nr and vim.tbl_get(t, "variables", varname, "id") == id then
      vim.cmd.tabclose(t.tabnr)
    end
  end
end

---find tabpage with given tabman page id
---@param id string: tabman page id
---@return number?: tabpage number if found
local function find(id)
  for _, t in ipairs(vim.fn.gettabinfo()) do
    if vim.tbl_get(t, "variables", varname, "id") == id then
      return t.tabnr
    end
  end
end

---force re-creating the tabman page
---@param cmd string|function: ex-command or lua function to create a new tabpage
---@param id string: tabman page id
---@return number tabpage id
---@return number tabpage number
local function recreate(id, cmd)
  local new_h, new_nr = _create(id, cmd)
  _clear_old(id, new_nr)
  return new_h, new_nr
end

---recreate current tabman page
local function recreate_current()
  local ok, info = pcall(vim.api.nvim_tabpage_get_var, 0, varname)
  if not ok then
    return
  end

  recreate(info.id, info.cmd)
  vim.notify("Recreated tabpage: " .. info.id, vim.log.levels.INFO)
end

---create the tabman page to jump to if it already exists
---@param cmd string|function: ex-command or lua function to create a new tabpage
---@param id string: tabman page id
local function open(id, cmd)
  local nr = find(id)
  if nr then
    vim.cmd.tabnext(nr)
  else
    _create(id, cmd)
  end
end

return {
  find = find,
  open = open,
  recreate = recreate,
  recreate_current = recreate_current,
}
