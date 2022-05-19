return function(bufnr)
  local nlua = function(key, cmd)
    local opts = { buffer = bufnr }
    require("mudox.keymap").nlua(key, cmd, opts)
  end
  local nmap = require("mudox.keymap").nmap

  -- goto
  nlua("gD", "vim.lsp.buf.declaration()")
  nlua("gd", "vim.lsp.buf.definition()")
  nlua("gT", "vim.lsp.buf.type_definition()")
  nlua("gi", "vim.lsp.buf.implementation()")
  nlua("gr", "vim.lsp.buf.references()")

  -- help
  nlua("gh", "vim.lsp.buf.hover()")
  nlua("gs", "vim.lsp.buf.signature_help()")

  -- refactor
  nlua("\\rn", "vim.lsp.buf.rename()")
  nlua("\\ca", "vim.lsp.buf.code_action()")
  nmap("\\fm", require("mudox.lsp.formatting").sync)

  -- diagnostics
  nlua("[d", "vim.diagnostic.goto_prev()")
  nlua("]d", "vim.diagnostic.goto_next()")
  nlua("gl", "vim.diagnostic.open_float()")
end
