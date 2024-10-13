---@class mudox.util.rootdir
---@field paths string[]
---@field strategy mudox.util.rootdir.strategy

---@alias mudox.util.rootdir.finder fun(bufnr: number): string[]
---@alias mudox.util.rootdir.strategy string|string[]|mudox.util.rootdir.finder
---@alias mudox.util.rootdir.result { paths: string[], strategy: mudox.util.rootdir.strategy }

---@type mudox.util.rootdir.strategy[]
local default_strategy = { "lsp", { ".git", "lua" }, "cwd" }

---Current working directory
---@return string "" on error
local function cwd()
  local p = vim.uv.fs_realpath(vim.uv.cwd() or "") or ""
  assert(p and p ~= "")
  return p
end

---Full file path for given buffer
---@param bufnr number
---@return string "" on error
local function bufpath(bufnr)
  return vim.api.nvim_buf_get_name(bufnr)
end

local finder = {}

---Finder: current working directory
---@return string[] # Empty list if not found
function finder.cwd()
  return { vim.uv.cwd() or "" }
end

---Finder: LSP workspace folder directories
---@return string[] # Empty list if not found
function finder.lsp(bufnr)
  local rootdirs = {} ---@type string[]
  for _, client in pairs(vim.lsp.get_clients { bufnr = bufnr }) do
    -- only check workspace folders, since we're not interested in clients
    -- running in single file mode
    for _, f in pairs(client.config.workspace_folders or {}) do
      table.insert(rootdirs, vim.uri_to_fname(f.uri))
    end
  end

  return vim.tbl_filter(function(path)
    return bufpath(bufnr):find(path, 1, true) == 1
  end, rootdirs)
end

---Finder: search upwards from buffer path or `cwd` for `patterns`
---@param bufnr number
---@param patterns string[]|string Wildcard pattern(s) not regex pattern(s)
---@return string[] # Empty list if not found
function finder.pattern(bufnr, patterns)
  patterns = type(patterns) == "string" and { patterns } or patterns
  local path = bufpath(bufnr) ~= "" and bufpath(bufnr) or cwd()
  local pattern = vim.fs.find(patterns, { path = path, upward = true })[1]
  return pattern and { vim.fs.dirname(pattern) } or {}
end

---@param strategy mudox.util.rootdir.strategy
---@return mudox.util.rootdir.finder
local function resolve(strategy)
  if type(strategy) == "function" then
    return strategy
  elseif type(strategy) == "string" then
    return finder[strategy]
  else
    assert(type(strategy) == "table")
    return function(bufnr)
      return finder.pattern(bufnr, strategy)
    end
  end
end

---@class mudox.util.rootdir.find_opts
---@field all? boolean

---Find root directory
---@param opts? { bufnr?: number, strategy?: mudox.util.rootdir.strategy[], all?: boolean }
---@return mudox.util.rootdir.result[]
local function find(opts)
  opts = opts or {}
  opts.bufnr = opts.bufnr or 0
  if vim.bo[opts.bufnr].buftype ~= "" then
    opts.strategy = { "cwd" }
  else
    opts.strategy = opts.strategy
      or (type(vim.g.mdx_rootdir_strategy) == "table" and vim.g.mdx_rootdir_strategy)
      or default_strategy
  end

  local results = {} ---@type mudox.util.rootdir.result[]
  for _, s in ipairs(opts.strategy) do
    local paths = resolve(s)(opts.bufnr)

    local rootdirs = {}
    for _, p in ipairs(paths) do
      rootdirs[p] = true
    end
    rootdirs = vim.tbl_keys(rootdirs)

    table.sort(rootdirs, function(a, b)
      return #a > #b
    end)

    if #rootdirs > 0 then
      results[#results + 1] = { strategy = s, paths = rootdirs }
      if opts.all == false then
        break
      end
    end
  end

  return results
end

local function info()
  local results = find()
  local lines = {} ---@type string[]

  for _, r in ipairs(results) do
    table.insert(lines, ("# %s"):format(vim.inspect(r.strategy)))
    for _, p in ipairs(r.paths) do
      table.insert(lines, ("  - %s"):format(p))
    end
  end

  print(table.concat(lines, "\n"))
end

---@type table<number, string>
local cache = {}

local function setup()
  -- vim.api.nvim_create_user_command("RootDirInfo", info, { desc = "[RootDir] Info" })

  On({ "LspAttach", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("mdx_rootdir_cache", { clear = true }),
    callback = function(event)
      cache[event.buf] = nil
    end,
  })
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
-- * cwd
---@return string
local function get()
  local bufnr = vim.api.nvim_get_current_buf()

  if cache[bufnr] then
    return cache[bufnr]
  end

  local roots = find { all = false }
  local ret = roots[1] and roots[1].paths[1] or cwd()
  cache[bufnr] = ret
  return ret
end

return {
  find = find,
  info = info,
  get = get,
  setup = setup,
}
