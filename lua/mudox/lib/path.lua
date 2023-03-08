local root_patterns = { ".git", "lua" }

-- returns the root directory based on:
-- * lsp workspace folder
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
local function get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil

  ---@type string[]
  local roots = {}

  if path then
    for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      local paths

      local workspaces = client.config.workspace_folders
      if workspaces then
        paths = vim.tbl_map(function(ws)
          return vim.uri_to_fname(ws.uri)
        end, workspaces)
      else
        if client.config.root_dir then
          paths = { client.config.root_dir }
        else
          paths = {}
        end
      end

      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end

  table.sort(roots, function(a, b)
    return #a > #b
  end)

  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end

  ---@cast root string
  return root
end

return {
  get_root = get_root,
}
