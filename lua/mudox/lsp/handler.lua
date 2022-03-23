local function setup_lsp_highlight_cursor(client)
  -- use `antoinemadec/FixCursorHold.nvim` to reduce update time without incuor
  -- frequent swap writing
  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end
end

local function install_lsp_buffer_mappings(bufnr)
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
function _G._mdx_async_format_document()
  local enabled_filetypes = {}

  if enabled_filetypes[vim.o.ft] then
    vim.lsp.buf.formatting()
  end
end

-- For instant formatting
function _G._mdx_sync_format_document()
  local enabled_filetypes = {
    lua = true,
    swift = true,
    python = true,
  }

  if enabled_filetypes[vim.o.ft] then
    vim.lsp.buf.formatting_sync()
  end
end

local function install_buffer_autocmds()
  vim.cmd([[
  au BufWritePre <buffer> lua _mdx_sync_format_document()
  au BufWritePost <buffer> lua _mdx_async_format_document()
  ]])
end

local function on_attach(client, bufnr)
  -- use prettier by null-ls instead
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  -- keymaps
  install_lsp_buffer_mappings(bufnr)

  -- highlighting cursor
  setup_lsp_highlight_cursor(client)

  install_buffer_autocmds()

  -- aerial.nvim
  require("aerial").on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

return {
  capabilities = capabilities,
  on_attach = on_attach,
}
