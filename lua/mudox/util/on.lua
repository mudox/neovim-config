local M = {}

---@param fn fun(client, bufnr)
---@param opts table|nil
function M.lsp_attach(fn, opts)
  opts = opts or {}

  vim.api.nvim_create_autocmd("LspAttach", {
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

  vim.api.nvim_create_autocmd("User", {
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

  vim.api.nvim_create_autocmd("User", {
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

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = opts.gid,
    desc = opts.desc,
    callback = fn,
  })
end

return M
