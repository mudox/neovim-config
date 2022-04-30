local function highlight_cursor(bufnr)
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

local function lsp_mappings(bufnr)
  local nlua = function(key, cmd)
    local opts = { buffer = bufnr }
    require("mudox.keymap").nlua(key, cmd, opts)
  end

  -- goto
  nlua("gD", "vim.lsp.buf.declaration()")
  nlua("gd", "vim.lsp.buf.definition()")
  nlua("gT", "vim.lsp.buf.type_definition()")
  nlua("gi", "vim.lsp.buf.implementation()")
  nlua("gr", "vim.lsp.buf.references()")

  -- help
  nlua("K", "vim.lsp.buf.hover()")
  nlua("J", "vim.lsp.buf.signature_help()")

  -- refactor
  nlua("\\rn", "vim.lsp.buf.rename()")
  nlua("\\ca", "vim.lsp.buf.code_action()")
  nlua("\\fm", "vim.lsp.buf.formatting()")

  -- diagnostics
  nlua("[d", "vim.diagnostic.goto_prev()")
  nlua("]d", "vim.diagnostic.goto_next()")
  nlua("gl", "vim.diagnostic.open_float()")
end

--- For slow formatting
local function format_document_async()
  local enabled_filetypes = {
    python = true,
  }

  if enabled_filetypes[vim.o.ft] then
    vim.lsp.buf.formatting()
  end
end

-- For instant formatting
local function format_document_sync()
  local enabled_filetypes = {
    lua = true,
    swift = true,
  }

  if enabled_filetypes[vim.o.ft] then
    vim.lsp.buf.formatting_sync()
  end
end

local function format_on_save(bufnr)
  local gid = vim.api.nvim_create_augroup("MudoxLspFormatOnSave", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = gid,
    buffer = bufnr,
    callback = format_document_sync,
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = gid,
    buffer = bufnr,
    callback = format_document_async,
  })
end

local function on_attach(client, bufnr)
  -- Use prettier by null-ls instead
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  -- Use stylua by null-ls instead
  if client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  lsp_mappings(bufnr)

  highlight_cursor(bufnr)

  format_on_save()

  require("aerial").on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

return {
  capabilities = capabilities,
  on_attach = on_attach,
}
