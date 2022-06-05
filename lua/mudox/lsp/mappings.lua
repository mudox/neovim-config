return function(bufnr)
  local nlua = function(key, cmd)
    local opts = { buffer = bufnr }
    require("mudox.keymap").nlua(key, cmd, opts)
  end
  local k = require("mudox.keymap")

  -- Goto
  nlua("gD", "vim.lsp.buf.declaration()")
  nlua("gd", "vim.lsp.buf.definition()")
  nlua("gT", "vim.lsp.buf.type_definition()")
  nlua("gi", "vim.lsp.buf.implementation()")
  nlua("gr", "vim.lsp.buf.references()")

  -- Help
  nlua("gh", "vim.lsp.buf.hover()")
  nlua("gs", "vim.lsp.buf.signature_help()")

  -- Refactor
  nlua("\\rn", "vim.lsp.buf.rename()")
  k.nexpr("\\ir", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, {silent = false})

  nlua("\\ca", "vim.lsp.buf.code_action()")

  k.nmap("\\fm", function()
    require("mudox.lsp.formatting").sync()
  end)

  -- Diagnostics
  nlua("<d", "vim.diagnostic.hide()")
  nlua(">d", "vim.diagnostic.show()")

  nlua("[d", "vim.diagnostic.goto_prev()")
  nlua("]d", "vim.diagnostic.goto_next()")

  nlua("gl", "vim.diagnostic.open_float()")
end
