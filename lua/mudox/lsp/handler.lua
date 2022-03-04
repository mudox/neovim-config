-- TODO: backfill this to template
local function setup()
  vim.cmd([[
    hi default link LspReferenceText CusorColumn
    hi default LspReferenceRead LspReferenceText
    hi default LspReferenceWrite LspReferenceText
  ]])

  local signs = {
    { name = "DiagnosticSignError", text = " " },
    { name = "DiagnosticSignWarn", text = " " },
    { name = "DiagnosticSignHint", text = " " },
    { name = "DiagnosticSignInfo", text = " " },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      border = "rounded",
      source = "always",
      header = "  Diagnostics",
      prefix = " - ",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
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
  setup = setup,
  on_attach = on_attach,
}
