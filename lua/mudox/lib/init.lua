---@param on_attach fun(client, buffer)
local function on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local buffer = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

---@param callback fun()
local function on_very_lazy(callback)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      callback()
    end,
  })
end

return {
  on_attach = on_attach,
  on_very_lazy = on_very_lazy,
}
