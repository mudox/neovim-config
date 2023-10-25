local root_patterns = { ".git", "lua" }

local logfile = vim.fn.stdpath("log") .. "/mudox.log"
local function log(text, opts)
  opts = opts or {}

  local level = opts.level or "DEBUG"
  level = ("[%s]"):format(level)

  local list = vim.fn.split(text, "\n", true)
  list = vim.tbl_map(function(line)
    return string.rep(" ", 10) .. line
  end, list)

  vim.fn.writefile(list, logfile, "a")
end

---@return string|nil
local function root_dir_from_lsp()
  ---@type string|nil
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  log(("buffer name: %s"):format(path))
  if not path then
    log("buffer has no path, return nil")
    return nil
  end

  for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
    local paths

    local workspaces = client.config.workspace_folders
    if workspaces then
      paths = vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspaces)
    elseif client.config.root_dir then
      paths = { client.config.root_dir }
    else
      paths = {}
    end

    for _, p in ipairs(paths) do
      local r = vim.loop.fs_realpath(p)
      if r and path:find(r, 1, true) then
        log(("found lsp root dir: %s"):format(r))
        return r
      end
    end
  end
end

---@return string|nil
local function root_dir_from_filename()
  ---@type string|nil
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  if not path then
    return nil
  end

  path = vim.fs.find(root_patterns, { path = path, upward = true })[1]
  path = vim.fs.dirname(path)
end

---@return string|nil
local function root_dir_from_cwd()
  ---@type string|nil
  local cwd = vim.loop.cwd()
  cwd = cwd ~= "" and vim.loop.fs_realpath(cwd) or nil
  if not cwd then
    return nil
  end

  local path = vim.fs.find(root_patterns, { path = cwd, upward = true })[1]
  path = path or cwd
  return vim.fs.dirname(path)
end

-- returns the root directory based on:
-- * (v:count 3) lsp workspace folder or project root dir if it contains current buffer file
-- * (v:count 1) root pattern in filename of the current buffer
-- * (v:count 2) root pattern in cwd
-- * cwd
local function smart_root_dir()
  return root_dir_from_lsp() or root_dir_from_filename() or root_dir_from_cwd() or vim.loop.cwd()
end

---@return string|nil
local function get_root_dir()
  if vim.v.count == 1 then
    return root_dir_from_filename()
  elseif vim.v.count == 2 then
    return root_dir_from_cwd()
  elseif vim.v.count == 3 then
    return root_dir_from_lsp()
  else
    return smart_root_dir()
  end
end

return {
  get_root_dir = get_root_dir,
}
