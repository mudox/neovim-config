
local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      set updatetime=300
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_mappings(bufnr)
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
  k("n", "<Bs>r", "vim.lsp.buf.rename()")
  k("n", "<Bs>a", "vim.lsp.buf.code_action()")
  k("n", "<Bs>f", "vim.lsp.buf.formatting()")

  -- diagnostic
  k("n", "[d", "vim.diagnostic.goto_prev()")
  k("n", "]d", "vim.diagnostic.goto_next()")
  k("n", "gl", "vim.diagnostic.open_float()")
end

local function on_attach(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  lsp_mappings(bufnr)
  lsp_highlight_document(client)

  -- aerial.nvim
  require("aerial").on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

return {
  capabilities = capabilities,
  on_attach = on_attach,
}
