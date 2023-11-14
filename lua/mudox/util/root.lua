---@class mudox.util.root
---@field paths string[]
---@field strategy mudox.util.root.strategy

---@alias mudox.util.root.fn fun(buf: number): string|string[]
---@alias mudox.util.root.strategy string|string[]|mudox.util.root.fn

---@type mudox.util.root.strategy[]
local default_strategies = { "lsp", { ".git", "lua" }, "cwd" }

local finders = {}

function finders.cwd()
  return { vim.loop.cwd() }
end

function finders.lsp(buf)
  local bufpath = M.bufpath(buf)
  if not bufpath then
    return {}
  end
  local roots = {} ---@type string[]
  for _, client in pairs(Util.lsp.get_clients { bufnr = buf }) do
    -- only check workspace folders, since we're not interested in clients
    -- running in single file mode
    local workspace = client.config.workspace_folders
    for _, ws in pairs(workspace or {}) do
      roots[#roots + 1] = vim.uri_to_fname(ws.uri)
    end
  end
  return vim.tbl_filter(function(path)
    path = Util.norm(path)
    return path and bufpath:find(path, 1, true) == 1
  end, roots)
end

---@param patterns string[]|string
function finders.pattern(buf, patterns)
  patterns = type(patterns) == "string" and { patterns } or patterns
  local path = M.bufpath(buf) or vim.loop.cwd()
  local pattern = vim.fs.find(patterns, { path = path, upward = true })[1]
  return pattern and { vim.fs.dirname(pattern) } or {}
end

function bufpath(buf)
  return realpath(vim.api.nvim_buf_get_name(assert(buf)))
end

function cwd()
  return realpath(vim.loop.cwd()) or ""
end

function realpath(path)
  if path == "" or path == nil then
    return nil
  end
  path = vim.loop.fs_realpath(path) or path
  return Util.norm(path)
end

---@param strategy mudox.util.root.strategy
---@return mudox.util.root.fn
function resolve(strategy)
  if finders[strategy] then
    return M.finders[strategy]
  elseif type(strategy) == "function" then
    return strategy
  end
  return function(buf)
    return finders.pattern(buf, strategy)
  end
end

---@param opts? { buf?: number, strategy?: ProjectRootSpec[], all?: boolean }
function M.detect(opts)
  opts = opts or {}
  opts.strategy = opts.spec or type(vim.g.root_spec) == "table" and vim.g.root_spec or M.spec
  opts.buf = (opts.buf == nil or opts.buf == 0) and vim.api.nvim_get_current_buf() or opts.buf

  local ret = {} ---@type ProjectRoot[]
  for _, strategy in ipairs(opts.spec) do
    local paths = M.resolve(strategy)(opts.buf)
    paths = paths or {}
    paths = type(paths) == "table" and paths or { paths }
    local roots = {} ---@type string[]
    for _, p in ipairs(paths) do
      local pp = M.realpath(p)
      if pp and not vim.tbl_contains(roots, pp) then
        roots[#roots + 1] = pp
      end
    end
    table.sort(roots, function(a, b)
      return #a > #b
    end)
    if #roots > 0 then
      ret[#ret + 1] = { strategy = spec, paths = roots }
      if opts.all == false then
        break
      end
    end
  end
  return ret
end

function M.info()
  local strategy = type(vim.g.root_spec) == "table" and vim.g.root_spec or M.spec

  local roots = M.detect { all = true }
  local lines = {} ---@type string[]
  local first = true
  for _, root in ipairs(roots) do
    for _, path in ipairs(root.paths) do
      lines[#lines + 1] = ("- [%s] `%s` **(%s)**"):format(
        first and "x" or " ",
        path,
        type(root.strategy) == "table" and table.concat(root.spec, ", ") or root.spec
      )
      first = false
    end
  end
  lines[#lines + 1] = "```lua"
  lines[#lines + 1] = "vim.g.root_strategy = " .. vim.inspect(spec)
  lines[#lines + 1] = "```"
  require("lazyvim.util").info(lines, { title = "LazyVim Roots" })
  return roots[1] and roots[1].paths[1] or vim.loop.cwd()
end

---@type table<number, string>
M.cache = {}

function M.setup()
  vim.api.nvim_create_user_command("ProjectRoot", function()
    Util.root.info()
  end, { desc = "LazyVim roots for the current buffer" })

  vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("lazyvim_root_cache", { clear = true }),
    callback = function(event)
      M.cache[event.buf] = nil
    end,
  })
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param opts? {normalize?:boolean}
---@return string
function M.get(opts)
  local buf = vim.api.nvim_get_current_buf()
  local ret = M.cache[buf]
  if not ret then
    local roots = M.detect { all = false }
    ret = roots[1] and roots[1].paths[1] or vim.loop.cwd()
    M.cache[buf] = ret
  end
  if opts and opts.normalize then
    return ret
  end
  return Util.is_win() and ret:gsub("/", "\\") or ret
end

return M
