local function highlight_cursor()
  for _, client in ipairs(vim.lsp.get_active_clients {}) do
    if client.server_capabilities.documentHighlightProvider ~= nil and not client.is_stopped() then
      vim.lsp.buf.document_highlight()
      return
    end
  end
end

return function(client, bufnr)
  if not client.server_capabilities.documentHighlightProvider then
    return
  end

  local gid = vim.api.nvim_create_augroup("MudoxLspHighlightCursor", { clear = true })

  -- NOTE: related plugin `FixCursorHold`

  vim.api.nvim_create_autocmd("CursorHold", {
    group = gid,
    buffer = bufnr,
    callback = highlight_cursor,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = gid,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end
