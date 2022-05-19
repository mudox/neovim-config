return function(client, bufnr)
  if not client.server_capabilities.documentHighlightProvider then
    return
  end

  local gid = vim.api.nvim_create_augroup("MudoxLspHighlightCursor", { clear = true })

  -- NOTE: related plugin `FixCursorHold`

  vim.api.nvim_create_autocmd("CursorHold", {
    group = gid,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = gid,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end
