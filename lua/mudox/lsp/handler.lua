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
  local k = function(mode, key, cmd, opts)
    opts = { noremap = true, silent = true }
    cmd = ("<Cmd>lua %s<Cr>"):format(cmd)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, cmd, opts)
  end

  -- goto
  k("n", "gD", "vim.lsp.buf.declaration()")
  k("n", "gd", "vim.lsp.buf.definition()")
  k("n", "gi", "vim.lsp.buf.implementation()")
  k("n", "gr", "vim.lsp.buf.references()")

  -- help
  k("n", "K", "vim.lsp.buf.hover()")
  k("n", "J", "vim.lsp.buf.signature_help()")

  -- refactor
  k("n", "\\rn", "vim.lsp.buf.rename()")
  k("n", "\\ca", "vim.lsp.buf.code_action()")
  k("n", "\\fm", "vim.lsp.buf.formatting()")

  -- diagnostic
  k("n", "[d", "vim.diagnostic.goto_prev()")
  k("n", "]d", "vim.diagnostic.goto_next()")
  k("n", "gl", "vim.diagnostic.open_float()")
end

local function on_attach(client, bufnr)
  -- use prettier by null-ls instead
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  install_lsp_buffer_mappings(bufnr)

  setup_lsp_highlight_cursor(client)

  -- aerial.nvim
  require("aerial").on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

return {
  capabilities = capabilities,
  on_attach = on_attach,
}
