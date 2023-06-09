---@param group_id number
---@param fn fun(client, bufnr)
local function on_lsp_attach(group_id, fn)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group_id,
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      fn(client, bufnr)
    end,
  })
end

---@param cb fun()
local function on_very_lazy(cb)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = cb,
  })
end

return {
  on_lsp_attach = on_lsp_attach,
  on_very_lazy = on_very_lazy,
}
