local M = {}

---@param fn fun(client, bufnr)
---@param opts table|nil
function M.lsp_attach(fn, opts)
  opts = opts or {}

  U.on("LspAttach", {
    group = opts.gid,
    desc = opts.desc,
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      fn(client, bufnr)
    end,
  })
end

---@param fn fun()
---@param opts table|nil
function M.very_lazy(fn, opts)
  opts = opts or {}

  U.on("User", {
    pattern = "VeryLazy",
    group = opts.gid,
    desc = opts.desc,
    callback = fn,
  })
end

---@param fn fun()
---@param opts table|nil
function M.start(fn, opts)
  opts = opts or {}

  U.on("User", {
    pattern = "MdxSessionStart",
    group = opts.gid,
    desc = opts.desc,
    callback = fn,
  })
end

---@param fn fun()
---@param opts table|nil
function M.colorscheme(fn, opts)
  opts = opts or {}

  U.on("ColorScheme", {
    group = opts.gid,
    desc = opts.desc,
    callback = fn,
  })
end

---@param pattern string|string[]
---@param fn fun()
---@param opts table|nil
function M.filetype(pattern, fn, opts)
  opts = opts or {}

  U.on("FileType", {
    pattern = pattern,
    group = opts.gid,
    desc = opts.desc,
    callback = fn,
  })
end

return setmetatable(M, {
  __call = function(_, ...)
    vim.api.nvim_create_autocmd(...)
  end,
})
